# Compatible with ranger 1.6.0 through 1.7.*
#
# This is a plugin that prints the OSC-7 escape when the directory changes

from __future__ import (absolute_import, division, print_function)
import ranger.api
import socket

HOOK_READY_OLD = ranger.api.hook_ready

hostname = socket.gethostname()


def hook_ready(fm):
    def emit_osc7(signal):
        if 'new' in signal:
            print(f"\033]7;file://{hostname}/{signal.new}\033\\", end="")

    fm.signal_bind("cd", emit_osc7)
    return HOOK_READY_OLD(fm)


ranger.api.hook_ready = hook_ready
