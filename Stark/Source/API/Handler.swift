import Foundation
import JavaScriptCore

public class Handler: NSObject {
    internal var callback: JSManagedValue?

    func manageCallback(_ callback: JSValue) {
        self.callback = JSManagedValue(value: callback, andOwner: self)
    }

    func call(withArguments arguments: [AnyObject]!) {
        if let callback = callback?.value {
            let scope = JSContext(virtualMachine: callback.context.virtualMachine)

            scope?.exceptionHandler = { _, exception in
                LogHelper.log(message: String(format: "JavaScript exception: %@", exception!))
            }

            let fn = JSValue(object: callback, in: scope)
            _ = fn?.call(withArguments: arguments)
        }
    }

    func call() {
        call(withArguments: [])
    }
}
