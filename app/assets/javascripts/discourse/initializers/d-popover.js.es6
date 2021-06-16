import {
  showPopover,
  hidePopover,
  POPOVER_SELECTORS
} from "discourse/lib/d-popover";

export default {
  name: "d-popover",

  initialize(container) {
    const router = container.lookup("router:main");
    router.on("routeWillChange", e => hidePopover(e, false));

    $("#main")
      .on("click.d-popover mouseenter.d-popover", POPOVER_SELECTORS, e =>
        showPopover(e)
      )
      .on("mouseleave.d-popover", POPOVER_SELECTORS, e => hidePopover(e, true));
  }
};
