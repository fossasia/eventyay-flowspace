from django.utils.translation import gettext_lazy as _

from . import __version__

try:
    from eventyay.base.plugins import PluginConfig
except ImportError:
    raise RuntimeError("Please use a later version of eventyay-tickets")


class FlowspaceApp(PluginConfig):
    default = True
    name = "flowspace"
    verbose_name = _("Flowspace")

    class EventyayPluginMeta:
        name = _("Flowspace")
        author = "FOSSASIA"
        description = _(
            "This plugin allows you to integrate Flowspace with your events"
        )
        visible = True
        version = __version__
        category = "FEATURE"

    def ready(self):
        from . import signals  # NOQA
