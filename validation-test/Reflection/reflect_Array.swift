// RUN: rm -rf %t && mkdir -p %t
// RUN: %target-build-swift -lswiftSwiftReflectionTest %s -o %t/reflect_Array
// RUN: %target-run %target-swift-reflection-test %t/reflect_Array 2>&1 | %FileCheck %s --check-prefix=CHECK-%target-ptrsize
// REQUIRES: objc_interop
// REQUIRES: executable_test

import SwiftReflectionTest

class TestClass {
    var t: Array<Int>
    init(t: Array<Int>) {
        self.t = t
    }
}

var obj = TestClass(t: [1, 2, 3])

reflect(object: obj)

// CHECK-64: Reflecting an object.
// CHECK-64: Type reference:
// CHECK-64-NEXT: (class reflect_Array.TestClass)

// CHECK-64: Type info:
// CHECK-64-NEXT: (class_instance size=24 alignment=8 stride=24 num_extra_inhabitants=0
// CHECK-64-NEXT:   (field name=t offset=16
// CHECK-64-NEXT:     (struct size=8 alignment=8 stride=8 num_extra_inhabitants=1
// CHECK-64-NEXT:       (field name=_buffer offset=0
// CHECK-64-NEXT:         (struct size=8 alignment=8 stride=8 num_extra_inhabitants=1
// CHECK-64-NEXT:           (field name=_storage offset=0
// CHECK-64-NEXT:             (struct size=8 alignment=8 stride=8 num_extra_inhabitants=1
// CHECK-64-NEXT:               (field name=rawValue offset=0
// CHECK-64-NEXT:                 (builtin size=8 alignment=8 stride=8 num_extra_inhabitants=1)))))))))

// CHECK-32: Reflecting an object.
// CHECK-32: Instance pointer in child address space: 0x{{[0-9a-fA-F]+}}
// CHECK-32: Type reference:
// CHECK-32: (class reflect_Array.TestClass)

// CHECK-32: Type info:
// CHECK-32: (class_instance size=16 alignment=4 stride=16 num_extra_inhabitants=0
// CHECK-32:   (field name=t offset=12
// CHECK-32:     (struct size=4 alignment=4 stride=4 num_extra_inhabitants=1
// CHECK-32:       (field name=_buffer offset=0
// CHECK-32:         (struct size=4 alignment=4 stride=4 num_extra_inhabitants=1
// CHECK-32:           (field name=_storage offset=0
// CHECK-32:             (struct size=4 alignment=4 stride=4 num_extra_inhabitants=1
// CHECK-32:               (field name=rawValue offset=0
// CHECK-32:                 (builtin size=4 alignment=4 stride=4 num_extra_inhabitants=1)))))))))

doneReflecting()

// CHECK-64: Done.

// CHECK-32: Done.
