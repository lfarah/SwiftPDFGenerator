/*
 * The MIT License (MIT)
 *
 * Copyright (c) 2016 cr0ss
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

import UIKit
//import Generator

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	@IBAction func generateButtonTouchUpInside(sender: UIButton) {
		var pages: Array<UIView> = []

		// Load Views with NibName
		let pageOneView = NSBundle.mainBundle().loadNibNamed("PageOneView", owner: self, options: nil).last as! PageOneView
		let pageTwoView = NSBundle.mainBundle().loadNibNamed("PageTwoView", owner: self, options: nil).last as! PageTwoView
		// Fill Views With Data
		pageOneView.setupViewContent()
		pageTwoView.setupViewContent()

		// Generate PDF from pages Array
		pages.appendContentsOf([pageOneView, pageTwoView])
		let tempFilePath = SwiftPDFGenerator.generatePDFWithPages(pages)

		// present PDF
		let newEventController = self.storyboard!.instantiateViewControllerWithIdentifier("PDFNavigationController") as! UINavigationController
		newEventController.modalPresentationStyle = .PageSheet
		let pdfLoc = NSURL(fileURLWithPath: tempFilePath)
		(newEventController.childViewControllers[0] as! DisplayController).url = pdfLoc
		self.presentViewController(newEventController, animated: true, completion: nil)
	}
}

