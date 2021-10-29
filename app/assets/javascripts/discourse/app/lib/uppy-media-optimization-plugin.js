import { UploadPreProcessorPlugin } from "discourse/lib/uppy-plugin-base";
import { Promise } from "rsvp";

export default class UppyMediaOptimization extends UploadPreProcessorPlugin {
  static pluginId = "uppy-media-optimization";

  constructor(uppy, opts) {
    super(uppy, opts);
    this.optimizeFn = opts.optimizeFn;

    // mobile devices have limited processing power, so we only enable
    // running media optimization in parallel when we are sure the user
    // is not on a mobile device. otherwise we just process the images
    // serially.
    this.runParallel = opts.runParallel || false;
  }

  _optimizeFile(fileId) {
    let file = this._getFile(fileId);

    this._emitProgress(file);

    return this.optimizeFn(file, { stopWorkerOnError: !this.runParallel })
      .then((optimizedFile) => {
        let skipped = false;
        if (!optimizedFile) {
          this._consoleWarn(
            "Nothing happened, possible error or other restriction, or the file format is not a valid one for compression."
          );
          skipped = true;
        } else {
          this._setFileState(fileId, {
            data: optimizedFile,
            size: optimizedFile.size,
          });
        }
        this._emitComplete(file, skipped);
      })
      .catch((err) => {
        this._consoleWarn(err);
        this._emitComplete(file);
      });
  }

  _optimizeParallel(fileIds) {
    return Promise.all(fileIds.map(this._optimizeFile.bind(this)));
  }

  async _optimizeSerial(fileIds) {
    let optimizeTasks = fileIds.map((fileId) => () =>
      this._optimizeFile.call(this, fileId)
    );

    for (const task of optimizeTasks) {
      await task();
    }
  }

  install() {
    if (this.runParallel) {
      this._install(this._optimizeParallel.bind(this));
    } else {
      this._install(this._optimizeSerial.bind(this));
    }
  }

  uninstall() {
    if (this.runParallel) {
      this._uninstall(this._optimizeParallel.bind(this));
    } else {
      this._uninstall(this._optimizeSerial.bind(this));
    }
  }
}
