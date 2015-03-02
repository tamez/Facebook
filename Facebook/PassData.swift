//
//  PassData.swift
//  Facebook
//
//  Created by dt on 3/1/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//


/* 

HOW TO: PASS DATA & HIJACK A SEGUE


A. In File A

1. Prepare func
override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {

2. Segue Destination & Casting
var destinationVc = segue.destinationViewController as ViewControllerB

3. Pass the Image...
destinationVc.passedImage = tappedImageView.image


B. In File B

4. Declare the image view
@IBOutlet weak var imageView: UIImageView!

5. ...Receive the Passed Image
var passedImage: UIImage!

6. Display the Passed Image

...viewDidLoad()

imageView.image = passedImage

*/