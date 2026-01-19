#!/bin/bash
set -euo pipefail

# shellcheck disable=SC1091
. /VERSIONS

set -x

/bin/bash /builds/tcl-build.sh
/bin/bash /builds/tcllib-build.sh
/bin/bash /builds/ns-build.sh
/bin/bash /builds/ns-modules-build-nsdbpg.sh
/bin/bash /builds/ns-modules-build-nsstats.sh
/bin/bash /builds/ns-modules-build-nsconf.sh
/bin/bash /builds/thread-build.sh
/bin/bash /builds/xotcl-build.sh
/bin/bash /builds/tdom-build.sh
/bin/bash /builds/rl_json-build.sh
