// REQUIRES: rdar37618912
// RUN: %empty-directory(%t)

// RUN: %target-swift-frontend -typecheck -F %S/Inputs/frameworks -DOLD -verify %s -Xcc -Wno-private-module
// RUN: %target-swift-frontend -typecheck -F %S/Inputs/frameworks -DNEW -verify %s -Xcc -Wno-private-module

import PrivateAsSubmodule.Private

#if OLD
import PrivateAsParallel.Private
#elseif NEW
import PrivateAsParallel_Private
#else
#error("OLD or NEW must be defined")
#endif

let _: Bool = PSGlobal // expected-error {{cannot convert value of type 'Int32'}}
let _: Bool = PSPrivateGlobal // expected-error {{cannot convert value of type 'Int32'}}
let _: Bool = PPGlobal // expected-error {{cannot convert value of type 'Int32'}}
let _: Bool = PPPrivateGlobal // expected-error {{cannot convert value of type 'Int32'}}
