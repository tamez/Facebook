//
//  KeyWindow.swift
//  Facebook
//
//  Created by dt on 3/1/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

/*

HOW TO: KEY WINDOW

All views in iOS belong to a window. Normally, apps only have a single window. You can add a view to the window directly if you want to easily cover all other views.

1. Get the Key Window
var window = UIApplication.sharedApplication().keyWindow

2. Add a View to the Window

The coordinate of the window is at the top left of the phone (0,0). It's sometimes useful to get the coordinate of an existing view in the coordinate system of the window. For example, if there is an image view embedded in some other view, you can get its frame in the coordinate system of the window by doing the following:

var frame = window.convertRect(imageView.frame, fromView: containerView)

3. 


*/
