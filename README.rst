Loungemesh
==========================

This is a plugin for `eventyay`_. 

This plugin allows you to integrate Loungemesh with your events

Development setup
-----------------

1. Make sure that you have a working `eventyay development setup`_.

2. Clone this repository.

3. Activate the `virtual environment <https://github.com/fossasia/eventyay?tab=readme-ov-file#getting-started>`_ you use for eventyay development.

4. Execute ``uv pip install -e .`` within this directory to register this application with the eventyay plugin registry.

5. Execute ``make`` within this directory to compile translations.

6. Restart your local eventyay server. You can now use the plugin from this repository for your events by enabling it in
   the 'plugins' tab in the settings.

This plugin has CI set up to enforce a few code style rules. To check locally, you need these packages installed::

    uv pip install -e '.[dev]'

To check your plugin for rule violations, run::

    ruff check .
    ruff format --check .

You can auto-fix some of these issues by running::

    ruff check --fix .
    ruff format .

To automatically check for these issues before you commit, you can run ``./.install-hooks.sh``.


License
-------


Copyright 2024 FOSSASIA

Released under the terms of the Apache License 2.0


.. _eventyay: https://github.com/fossasia/eventyay
.. _eventyay development setup: https://github.com/fossasia/eventyay?tab=readme-ov-file#getting-started
