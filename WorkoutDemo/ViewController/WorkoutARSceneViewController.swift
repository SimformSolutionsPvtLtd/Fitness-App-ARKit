//
//  WorkoutARSceneViewController.swift
//  WorkoutDemo
//
//  Created by Amit Kajwani on 28/11/19.
//  Copyright © 2019 Vishal Patel. All rights reserved.
//

import UIKit
import ARKit

class WorkoutARSceneViewController: UIViewController, ARSCNViewDelegate {
    
    // MARK: - IBOutlet
    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet weak var sliderView: UIView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var tapToStartView: UIView!
    @IBOutlet weak var tapToStartInnerView: UIView!
    
    // MARK: - Variables
    private let guidanceOverlay = ARCoachingOverlayView()
    var configuration = ARWorldTrackingConfiguration()
    var currentNode: SCNNode?
    var workout: WorkoutModel?
    var isAnimationPlay: Bool = true
    var sliderValue = Slider.value
    var sliderLabel: UILabel?
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Create a session configuration
        configuration.isLightEstimationEnabled = true
        configuration.planeDetection = .horizontal
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Pause a session
        sceneView.session.pause()
    }
    
    // MARK: - Setup
    func setup() {
        // Set delegate
        sceneView.delegate = self
        sceneView.automaticallyUpdatesLighting = true
        sceneView.autoenablesDefaultLighting = true
        
        if ARWorldTrackingConfiguration.supportsFrameSemantics(.personSegmentationWithDepth) {
            configuration.frameSemantics.insert(.personSegmentation)
        }
        setOverlay(automatically: true, forDetectionType: .horizontalPlane)
        
        // Set Screen title
        if let workout = self.workout { self.title = workout.name }
        
        // Add tap getsure
        addTapGestureToSceneView()
        
        // Add target for update Slider value
        slider.addTarget(self, action: #selector(WorkoutARSceneViewController.changeValue(_:)), for: .valueChanged)
        
        // Play pause button
        setupButtonPlayPause()
        
        // Slider label
        setupSliderLabel()
        
        // Tap to start inner view
        tapToStartInnerView.setOverlay()
    }
    
    // MARK: - Custom Functions
    func setOverlay(automatically: Bool, forDetectionType goal: ARCoachingOverlayView.Goal) {
        
        //1. Link The GuidanceOverlay To Our Current Session
        guidanceOverlay.session = sceneView.session
        guidanceOverlay.delegate = self
        sceneView.addSubview(guidanceOverlay)
        
        //2. Set It To Fill Our View
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item:  guidanceOverlay, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item:  guidanceOverlay, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item:  guidanceOverlay, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item:  guidanceOverlay, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
        ])
        
        guidanceOverlay.translatesAutoresizingMaskIntoConstraints = false
        
        //3. Enable The Overlay To Activate Automatically Based On User Preference
        guidanceOverlay.activatesAutomatically = automatically
        
        //4. Set The Purpose Of The Overlay Based On The User Preference
        guidanceOverlay.goal = goal
    }
    
    func addTapGestureToSceneView() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTap(withGestureRecognizer:)))
        tapToStartView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func addWorkoutNode(hitResult: ARHitTestResult) {
        if let workout = workout, let workoutName = Workout(rawValue: workout.name) {
            let workoutNode = WorkoutNode(hitResult: hitResult, workout: workoutName.modelName)
            currentNode = workoutNode
            sceneView.scene.rootNode.addChildNode(currentNode!)
        }
        // Set slider default value and update
        slider.value = sliderValue
        changeValue(slider)
    }
    
    func updateModelAnimationSpeed(value: Float) {
        NotificationCenter.default.post(name: .workoutSpeed, object: nil, userInfo: [Key.workoutSpeedValue: (value/Slider.valueDividedBy)])
    }
    
    func disappearTapToStartView() {
        UIView.animate(withDuration: Animation.durationForHidingLabel) { self.tapToStartView.set(alpha: 0) }
    }
    
    func setupButtonPlayPause() {
        playPauseButton.setTintColorOfImage(color: .white)
        playPauseButton.setCornerRadius(radius: 23)
    }
    
    func setupSliderLabel() {
        sliderLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 61, height: 22))
        sliderLabel?.setSliderLabel()
        sliderLabel?.center.x = CGFloat(170)
        sliderLabel?.center.y = CGFloat(15)
        slider.superview?.addSubview(sliderLabel!)
    }
    
    func updateSliderLabel(sender: UISlider) {
        let _thumbRect: CGRect = sender.thumbRect(forBounds: sender.bounds, trackRect: sender.trackRect(forBounds: sender.bounds), value: sender.value)
        let thumbRect: CGRect = view.convert(_thumbRect, from: sender)
        sliderLabel?.center.x = CGFloat(thumbRect.midX - 82)
        sliderLabel?.center.y = CGFloat(15)
    }
    
    func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        print("Passing all touches to the next view (if any), in the view stack.")
        return true
    }
    
    // MARK: - Selector Functions
    @objc func didTap(withGestureRecognizer recognizer: UIGestureRecognizer) {
        if currentNode == nil {
            disappearTapToStartView()
            let tapPoint = recognizer.location(in: sceneView)
            let result = sceneView.hitTest(tapPoint, types: .existingPlaneUsingExtent)
            if result.count == 0 { return }
            guard let hitResult = result.first else { return }
            addWorkoutNode(hitResult: hitResult)
        }
    }
    
    @objc func changeValue(_ sender: UISlider) {
        sliderValue = slider.value
        updateModelAnimationSpeed(value: sliderValue)
        updateSliderLabel(sender: sender)
    }
    
    // MARK: - IBAction
    @IBAction func buttonPlayPauseClicked(_ sender: UIButton) {
        isAnimationPlay = !isAnimationPlay
        sender.set(image: isAnimationPlay ? Image.pause : Image.play) // Change button image
        sliderView.setView(hidden: isAnimationPlay ? false : true) // Hide slider view
        updateModelAnimationSpeed(value: isAnimationPlay ? sliderValue : 0) // Update model animation
    }
    
}// End of Class

// MARK: - ARSessionObserver
extension WorkoutARSceneViewController {
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        if let arError = error as? ARError {
            switch arError.errorCode {
            case 102:
                configuration.worldAlignment = .gravity
                restartSessionWithoutDelete()
            default:
                restartSessionWithoutDelete()
            }
        }
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
    }
    
    func restartSessionWithoutDelete() {
        // Restart session with a different worldAlignment - prevents bug from crashing app
        sceneView.session.pause()
        sceneView.session.run(configuration, options: [
            .resetTracking,
            .removeExistingAnchors])
    }
    
}// End of Extension

// MARK: - ARCoachingOverlayViewDelegate
extension WorkoutARSceneViewController: ARCoachingOverlayViewDelegate {
    
    //1. Called When The ARCoachingOverlayView Is Active And Displayed
    func coachingOverlayViewWillActivate(_ coachingOverlayView: ARCoachingOverlayView) { }
    
    //2. Called When The ARCoachingOverlayView Is No Active And No Longer Displayer
    func coachingOverlayViewDidDeactivate(_ coachingOverlayView: ARCoachingOverlayView) {
        // Show label and button after coaching overlay did finish
        tapToStartView.setView(hidden: false)
    }
    
    //3. Called When Tracking Conditions Are Poor Or The Seesion Needs Restarting
    func coachingOverlayViewDidRequestSessionReset(_ coachingOverlayView: ARCoachingOverlayView) { }
    
}// End of Extension
