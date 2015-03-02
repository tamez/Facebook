//
//  NewsFeedViewController.swift
//  Facebook
//
//  Created by Timothy Lee on 8/3/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

import UIKit

// Delegate Two Methods for Custom Animated Transitions 
class NewsFeedViewController: UIViewController, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var feedImageView: UIImageView!
    
    // Frame: Image variables must be UIImageView to get the frame.
    var tappedImageView: UIImageView! // UIImage to UIImageView
    var transferImageView: UIImageView! // UIImage to UIImageView
    
    // Frame: Start & end frames allow precise image placement.
    var startFrame: CGRect!
    var endFrame: CGRect!
    
    // Track if the Vc isPresenting
    var isPresenting: Bool = true

    
    
    // LOAD IT UP!
    override func viewDidLoad() {
        super.viewDidLoad()

    // Configure the content size of the scroll view
        scrollView.contentSize = CGSizeMake(320, feedImageView.image!.size.height)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    
    // Tim's Scroll View Code
        scrollView.contentInset.top = 0
        scrollView.contentInset.bottom = 50
        scrollView.scrollIndicatorInsets.top = 0
        scrollView.scrollIndicatorInsets.bottom = 50
    }
    
    // Custom Transition: Delegate Method for Presented
    func animationControllerForPresentedController(presented: UIViewController!, presentingController presenting: UIViewController!, sourceController source: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        isPresenting = true
        return self
    }
    
    // Custom Transition: Delegate Method for Dismissed
    func animationControllerForDismissedController(dismissed: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        isPresenting = false
        return self
    }
    
    // Custom Transition: Method for Controls
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        // The value here should be the duration of the animations scheduled in the animationTransition method
        return 0.4
    }
    
    // Custom Transition: Animation & Controls 
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        //  println("animating transition")
        var containerView = transitionContext.containerView()
        var toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        var fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        
        // Custom Transition: Add Transition Image & Match Frames
        transferImageView = UIImageView(frame: tappedImageView.frame)
        transferImageView.image = tappedImageView.image
        transferImageView.contentMode = tappedImageView.contentMode
        transferImageView.clipsToBounds = tappedImageView.clipsToBounds
        
        // Custom Transition: Additional Matching of Frames in Scroll View
        var frame = containerView.convertRect(tappedImageView.frame, fromView: scrollView)
        transferImageView.frame = frame

        
        // Key Window: Setup Window to Pass Image
        var windowA = UIApplication.sharedApplication().keyWindow!

        // Key Window: Add Image to the  Window
        windowA.addSubview(transferImageView)
       
        
        // Presenting
        if (isPresenting) {
            containerView.addSubview(toViewController.view)
            toViewController.view.alpha = 0
            
            // Casting Vc & Set Final Image
            var photoVcA = toViewController as PhotoViewController
            var finalImageView = photoVcA.imageView
            photoVcA.imageView.hidden = true

            UIView.animateWithDuration(0.4, animations: { () -> Void in
                // Show the transfer image
                toViewController.view.alpha = 1
                
                // Set the Final Frame
                self.transferImageView.frame = self.endFrame
                }) { (finished: Bool) -> Void in
                    transitionContext.completeTransition(true)
                    photoVcA.imageView.hidden = false
                    self.transferImageView.removeFromSuperview()
                    }
            
        // Animate back to the Thumbnail
        } else {
           
            // Make a copy of the opened image view and match frames
            var photoVcB = fromViewController as PhotoViewController
            transferImageView.frame = photoVcB.imageView.frame
            
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                fromViewController.view.alpha = 0
                self.transferImageView.frame = frame
                self.transferImageView.alpha = 0
                
                }) { (finished: Bool) -> Void in
                    transitionContext.completeTransition(true)
                    self.transferImageView.removeFromSuperview()
                    fromViewController.view.removeFromSuperview()
                    
            }
        }
    }
    
    
    // HIJACK THE SEGUE + CUSTOM ANIMATED TRANSITION
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        
        // Pass Data Setup & Casting
        var destinationVc = segue.destinationViewController as PhotoViewController
        // Pass the Image...
        destinationVc.passedImage = tappedImageView.image
        
        // Set up the Custom Animated Transition 
        destinationVc.modalPresentationStyle = UIModalPresentationStyle.Custom
        destinationVc.transitioningDelegate = self
        
        // Key Window: Setup to Pass the Frame
        var windowB = UIApplication.sharedApplication().keyWindow!
        // Key Window: The Start Frame
        startFrame = windowB.convertRect(tappedImageView.frame, fromView: scrollView)
        
        // Key Window: Calculate the Image Height & End Frame Size
        // We use image!.size vs. frame for accuracy.
        var height = (tappedImageView.image!.size.height*320)/tappedImageView.image!.size.width
        endFrame = CGRect(x: 0, y: (view.frame.size.height - height)/2, width: 320, height: height)
        
        // Pass the Frame...
        destinationVc.endFrame = endFrame
    }
    
    
    
    @IBAction func tapThumbnail(sender: UITapGestureRecognizer) {
        var imageView = sender.view as UIImageView
        tappedImageView = imageView
        performSegueWithIdentifier("imageDetailSegue", sender: self)
        println("hi hi")
    }
    
}
