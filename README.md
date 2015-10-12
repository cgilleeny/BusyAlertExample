# BusyAlertExample
Simple class for UIAlertController with UIActivityIndicator and cancel button for long running tasks

Apple frowns on subclassing UIAlertController so this class adds a UIActivityIndicator to a UIAlertController initialized in the class Init function.  Also, the class defines a protocol with the function "didCancelBusyAlert" which the parent view controller must implement.  The BusyAlert is presnted using the class display() method and dismissed using the class dismiss() method.  I recommend using a lazy var to initialize the BusyAlert class instance.  The lazy var should initialize the class with a title and message to appear in the UIAlertController and the presenting view controller.  Also, the class delegate should be set to the presenting view controller.
