//
//  CustomTransition.swift
//  Facebook
//
//  Created by dt on 3/1/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

/*

HOW TO: CUSTOM ANIMATED TRANSITION 


1. Set up the transition
//override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
//var destinationVC = segue.destinationViewController as UIViewController
destinationVC.modalPresentationStyle = UIModalPresentationStyle.Custom // Crucial!
destinationVC.transitioningDelegate = self } // Crucial!

2. Delegate Methods + Track "isPresenting" / dismissed
class MyViewController: UIViewController, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
var isPresenting: Bool = true
...
}

3. Add the Delegate Methods
func animationControllerForPresentedController(presented: UIViewController!, presentingController presenting: UIViewController!, sourceController source: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
isPresenting = true
return self
}

func animationControllerForDismissedController(dismissed: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
isPresenting = false
return self
}

4. Add antother Method for Controls and Animation

func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
// The value here should be the duration of the animations scheduled in the animationTransition method
return 0.4
}

func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
// TODO: animate the transition in the next step
}

5. Animate the Transition. This is a fade.
func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
println("animating transition")
var containerView = transitionContext.containerView()
var toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
var fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!

if (isPresenting) {
containerView.addSubview(toViewController.view)
toViewController.view.alpha = 0
UIView.animateWithDuration(0.4, animations: { () -> Void in
toViewController.view.alpha = 1
}) { (finished: Bool) -> Void in
transitionContext.completeTransition(true)
}

// Dismissed
} else {
UIView.animateWithDuration(0.4, animations: { () -> Void in
fromViewController.view.alpha = 0
}) { (finished: Bool) -> Void in
transitionContext.completeTransition(true)
fromViewController.view.removeFromSuperview()
}
}
}


*/