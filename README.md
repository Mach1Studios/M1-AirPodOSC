# M1-AirPodOSC

### Description
Initial OSC transmitter for Apple AirPods Pro or any other device supported by (CoreMotion's Headphone Motion Manager)[https://developer.apple.com/documentation/coremotion/cmheadphonemotionmanager].

### Setup
 - run `pod install`
 - open .xcworkspace file

### OSC Orientation Output
Outputs with this Euler angle convention: 

#### (Mach1 Internal Angle Standard)[https://dev.mach1.tech/#mach1-internal-angle-standard]: Orientation Euler
- Yaw[0]+ = rotate right [Range: 0->360 | -180->180]
- Yaw[0]- = rotate left [Range: 0->360 | -180->180]
- Pitch[1]+ = rotate up [Range: -90->90]
- Pitch[1]- = rotate down [Range: -90->90]
- Roll[2]+ = tilt right [Range: -90->90]
- Roll[2]- = tilt left [Range: -90->90] 
_The orientation convention is based on the first person perspective point of view to make interfacing as easy to interpret as possible._

For more information please read about describing 3D motions here: https://research.mach1.tech/posts/describing-3d-motion

### Notes
 - Ensure to add the required Privacy descriptions in the `Info.plist`

