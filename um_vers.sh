#!/bin/bash
# Determine product and version for a UM library.
# usage: um_vers.sh <liblbm.so path>
# Accurate for all UM versions 5.x and 6.x

## Copyright and License
#
# All of the documentation and software included in this and any
# other Informatica Ultra Messaging GitHub repository
# Copyright (C) Informatica. All rights reserved.
#
# Permission is granted to licensees to use
# or alter this software for any purpose, including commercial applications,
# according to the terms laid out in the Software License Agreement.
#
# This source code example is provided by Informatica for educational
# and evaluation purposes only.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND INFORMATICA DISCLAIMS ALL WARRANTIES
# EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION, ANY IMPLIED WARRANTIES OF
# NON-INFRINGEMENT, MERCHANTABILITY OR FITNESS FOR A PARTICULAR
# PURPOSE.  INFORMATICA DOES NOT WARRANT THAT USE OF THE SOFTWARE WILL BE
# UNINTERRUPTED OR ERROR-FREE.  INFORMATICA SHALL NOT, UNDER ANY CIRCUMSTANCES,
# BE LIABLE TO LICENSEE FOR LOST PROFITS, CONSEQUENTIAL, INCIDENTAL, SPECIAL OR
# INDIRECT DAMAGES ARISING OUT OF OR RELATED TO THIS AGREEMENT OR THE
# TRANSACTIONS CONTEMPLATED HEREUNDER, EVEN IF INFORMATICA HAS BEEN APPRISED OF
# THE LIKELIHOOD OF SUCH DAMAGES.

s=$(strings -a "$1")

# Get the embedded version (prod name can be inaccurate).
emb=$(grep -E "^(UM[SPQ]|LBM) [0-9]+\.[0-9]+" <<<"$s" | sort -u | head -1)
ver=${emb#* }

# Since embedded prod name can be wrong, use symbols.
if grep -q '^lbm_umq_ctlr_queue_lookup$' <<<"$s"; then
  prod=UMQ
elif grep -q '^lbm_ume_rcv_ack_create$' <<<"$s"; then
  prod=UMP
else
  prod=UMS
fi

echo "$prod $ver"
