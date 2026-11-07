# um_vers

Given a `liblbm.so` (the Ultra Messaging core library), report which
product it is (UMS, UMP or UMQ) and which version.

## Copyright and License

All of the documentation and software included in this and any
other Informatica Ultra Messaging GitHub repository
Copyright (C) Informatica. All rights reserved.

Permission is granted to licensees to use
or alter this software for any purpose, including commercial applications,
according to the terms laid out in the Software License Agreement.

This source code example is provided by Informatica for educational
and evaluation purposes only.

THE SOFTWARE IS PROVIDED "AS IS" AND INFORMATICA DISCLAIMS ALL WARRANTIES
EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION, ANY IMPLIED WARRANTIES OF
NON-INFRINGEMENT, MERCHANTABILITY OR FITNESS FOR A PARTICULAR
PURPOSE.  INFORMATICA DOES NOT WARRANT THAT USE OF THE SOFTWARE WILL BE
UNINTERRUPTED OR ERROR-FREE.  INFORMATICA SHALL NOT, UNDER ANY CIRCUMSTANCES,
BE LIABLE TO LICENSEE FOR LOST PROFITS, CONSEQUENTIAL, INCIDENTAL, SPECIAL OR
INDIRECT DAMAGES ARISING OUT OF OR RELATED TO THIS AGREEMENT OR THE
TRANSACTIONS CONTEMPLATED HEREUNDER, EVEN IF INFORMATICA HAS BEEN APPRISED OF
THE LIKELIHOOD OF SUCH DAMAGES.

## Usage

    ./um_vers.sh liblbm.so

Output is one line, `<product> <version>`. E.g.

    UMP 6.14
    UMS 5.2.1

Requires `bash`, `strings` (binutils) and `grep`. Works on any 5.x or
6.x library that is not stripped.

## How it works

- **Version:** taken from the `lbm_version()` string embedded in the
  library (`UMS 5.2.1`, or `LBM 5.0.0.3` in older builds).
- **Product:** the embedded product name is unreliable (some versions
  always say `UMS`), so it is decided from symbols:
  - `lbm_umq_ctlr_queue_lookup` present: UMQ
  - else `lbm_ume_rcv_ack_create` present: UMP
  - otherwise: UMS

## Accuracy

Checked against UM versions 5.x and 6.x
