//
//  RoamWheelySlice.swift
//  RoamWheely
//
//  Created by Gustavo Colaço on 18/07/21.
//

import UIKit

class RoamWheelySlice: CALayer{
    
    private var startAngle: CGFloat!
    
    private var sectorAngle: CGFloat = -1
    
    private var slice: Slice!
    
    
    init(frame: CGRect, startAngle: CGFloat, sectorAngle: CGFloat, slice: Slice) {
        super.init()
        
        self.startAngle     = startAngle
        self.sectorAngle    = sectorAngle
        self.slice          = slice
        self.frame          = frame.inset(by: UIEdgeInsets(top: -10, left: 0, bottom: -10, right: 0))
        
        self.contentsScale  = UIScreen.main.scale
        self.masksToBounds  = true
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func draw(in ctx: CGContext) {
        let radius      = self.frame.width/2 - slice.borderWidth
        let center      = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        let height      = 2 * (1 - cos(sectorAngle/2))
        let textLabel   = UILabel(frame: .zero)
        textLabel.text  = slice.option
        
        
        
        let lineLegth        = CGFloat((2 * radius * sin(sectorAngle/2)))

        let perimeterSize    = (radius + radius + lineLegth)/2
        
        let inCenterDiameter = ((perimeterSize * (perimeterSize - radius) * (perimeterSize - radius) * (perimeterSize - lineLegth)).squareRoot()/perimeterSize) * 1.50
        
        var size: CGFloat    = 0
        
        size = sectorAngle == CGFloat(180).toRadians() ? radius/2 : sectorAngle == CGFloat(120).toRadians() ?  radius/1.9 : sectorAngle == CGFloat(90).toRadians() ? radius/1.9 : inCenterDiameter

        size -= slice.borderWidth * 3

        let xIncenter = ((radius * radius) + ((radius * cos(sectorAngle)) * radius))/(radius + radius + lineLegth) + (size * 0.07)
        let yIncenter = ((radius * sin(sectorAngle)) * radius)/(radius + radius + lineLegth)
        

        let xPosition:CGFloat = sectorAngle == CGFloat(180).toRadians() ? (-size/2) : sectorAngle == CGFloat(120).toRadians() ? (radius/2.7 - size/2) : sectorAngle == CGFloat(90).toRadians() ? (radius/2.4 - size/2) : ((xIncenter - size/2) + height)
        
        let yPosition:CGFloat = sectorAngle == CGFloat(180).toRadians() ? size/1.6 : sectorAngle == CGFloat(120).toRadians() ? (radius/2 - size/2) : sectorAngle == CGFloat(90).toRadians() ? (radius/2.4 - size/2) : (yIncenter - size/2)
        
        UIGraphicsPushContext(ctx)
        
        let path        = UIBezierPath.init()
        path.lineWidth  = slice.borderWidth
        path.move(to: center)
        path.addArc(withCenter: center, radius: radius, startAngle: startAngle, endAngle: startAngle + sectorAngle, clockwise: true)
        path.close()
        
        slice.color.setFill()
        path.fill()
        
        slice.borderColour.setStroke()
        path.stroke()
        
        ctx.saveGState()
        ctx.translateBy(x: center.x, y: center.y)
        ctx.rotate(by: startAngle)
        
        
        textLabel.drawText(in: CGRect(x: xPosition, y: yPosition , width: size, height: size))
        ctx.restoreGState()
        UIGraphicsPopContext()
    }
    
}
