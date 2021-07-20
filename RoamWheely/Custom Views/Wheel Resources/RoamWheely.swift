//
//  RoamWheely.swift
//  RoamWheely
//
//  Created by Gustavo Colaço on 18/07/21.
//

import UIKit

protocol RoamWheelyDelegate: NSObject {
    func shouldSelectObject() -> Int?
    func finishedSelecting(index: Int? , error: Error?)
}


class RoamWheely: UIView {
    
    private lazy var indicatorSize: CGSize = {
        let size = CGSize.init(width: self.bounds.width * 0.126 , height: self.bounds.height * 0.126)
        return size
    }()
    
    private var indicator               = UIImageView()
    var spinButton                      = UIButton(type: .custom)
    
    private var sectorAngle: CGFloat    = 0
    private var selectionAngle: CGFloat = 0
    
    var selectionIndex: Int             = -1
    
    private var wheelView: UIView!
    private var slices: [Slice]?
    
    weak var delegate: RoamWheelyDelegate?

    init(center: CGPoint, diameter : CGFloat , slices : [Slice]) {
        super.init(frame: CGRect(origin: CGPoint.init(x: center.x - diameter/2, y: center.y - diameter/2), size: CGSize.init(width: diameter, height: diameter)))
        self.slices = slices
        initialSetUp()
    }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func initialSetUp() {
        backgroundColor = .clear
        configureWheelView()
        configureSpinButton()
        configureIndicator()
    }
    
    
    private func configureWheelView() {
        let width               = self.bounds.width - self.indicatorSize.width
        let height              = self.bounds.height - self.indicatorSize.height
        
        let xPosition: CGFloat  = (self.bounds.width/2) - (width/2)
        let yPosition: CGFloat  = (self.bounds.height/2) - (height/2)
        
        wheelView                      = UIView(frame: CGRect.init(x: xPosition, y: yPosition, width: width, height: height))
        wheelView.backgroundColor      = .gray
        wheelView.layer.cornerRadius   = width/2
        wheelView.clipsToBounds        = true
        addSubview(self.wheelView)
        
        addWheelLayer()
    }
    
    
    private func addWheelLayer() {
        if let slices = slices {
            
            if slices.count >= 2 {
                wheelView.layer.sublayers?.forEach({$0.removeFromSuperlayer()})

                sectorAngle = (2 * CGFloat.pi)/CGFloat(slices.count)
       
                for (index,slice) in slices.enumerated() {
                    let sector = RoamWheelySlice(frame: wheelView.bounds, startAngle: sectorAngle * CGFloat(index), sectorAngle: sectorAngle, slice: slice)
                    wheelView.layer.addSublayer(sector)
                    sector.setNeedsDisplay()
                }
            } else {
                performFinish(error: RWErrorMessage.notEnoughSlices)
            }
        } else{
            performFinish(error: RWErrorMessage.notEnoughSlices)
        }
    }
    
    
    private func configureIndicator() {
        
        let position    = CGPoint(x: frame.width - indicatorSize.width, y: bounds.height/2 - indicatorSize.height/2)
        
        indicator.frame = CGRect(origin: position, size: indicatorSize)
        indicator.image = UIImage(named: "pointer")
        
        if indicator.superview == nil {
            self.addSubview(indicator)
        }
        
    }
    
    
    private func configureSpinButton() {
        let size    = CGSize(width: bounds.width * 0.2, height: bounds.height * 0.2)
        let point   = CGPoint(x:  frame.width/2 - size.width/2, y: frame.height/2 - size.height/2 + 130)
        
        spinButton.setTitle("Spin", for: .normal)
        spinButton.frame = CGRect(origin: point, size: size)
        
        spinButton.addTarget(self, action: #selector(startAction(sender:)), for: .touchUpInside)
        
        spinButton.layer.cornerRadius   = spinButton.frame.height/2
        spinButton.layer.borderWidth    = 0.5
        spinButton.layer.borderColor    = UIColor.white.cgColor

        spinButton.clipsToBounds        = true
        
        spinButton.backgroundColor      = .systemPurple
        
        self.addSubview(spinButton)
    }
    
    
    @objc private func startAction(sender: UIButton) {
        spinButton.isEnabled = false
        spinButton.buttonAnimation(spinButton)

        if let slicesCount = slices?.count {
            
            if let index = delegate?.shouldSelectObject() {
                selectionIndex = index
            }
            
            if (selectionIndex >= 0 && selectionIndex < slicesCount ) {
                performSelection()
            } else {
                performFinish(error: RWErrorMessage.genericError)
            }
            
        } else {
            performFinish(error: RWErrorMessage.notEnoughSlices)
        }
    }
    
    
    func performFinish(error : Error?){
        if let error = error {
            delegate?.finishedSelecting(index: nil, error: error)
        } else {
            wheelView.transform = CGAffineTransform.init(rotationAngle:selectionAngle)
            delegate?.finishedSelecting(index: selectionIndex, error: nil)
        }
        
        if !spinButton.isEnabled {
            spinButton.isEnabled = true
        }
    }
    
    
    func performSelection() {
        var selectionSpinDuration: Double = 1
        
        selectionAngle      = CGFloat(360).toRadians() - (sectorAngle * CGFloat(selectionIndex))
        let borderOffset    = sectorAngle * 0.1
        selectionAngle      -= CGFloat.random(in: borderOffset...(sectorAngle - borderOffset))
        
        if selectionAngle < 0 {
            selectionAngle  = CGFloat(360).toRadians() + selectionAngle
            selectionSpinDuration += 0.5
        }
        
        var delay : Double = 0
        
        let fastSpin                = CABasicAnimation(keyPath: "transform.rotation")
        fastSpin.fromValue          = NSNumber(floatLiteral: 0)
        fastSpin.toValue            = NSNumber(floatLiteral: .pi * 2)
        fastSpin.duration           = 0.7
        fastSpin.repeatCount        = 3
        fastSpin.beginTime          = CACurrentMediaTime() + delay
        delay                       += Double(fastSpin.duration) * Double(fastSpin.repeatCount)
        
        let slowSpin                = CABasicAnimation(keyPath: "transform.rotation")
        slowSpin.fromValue          = NSNumber.init(floatLiteral: 0)
        slowSpin.toValue            = NSNumber.init(floatLiteral: .pi * 2)
        slowSpin.isCumulative       = true
        slowSpin.beginTime          = CACurrentMediaTime() + delay
        slowSpin.repeatCount        = 1
        slowSpin.duration           = 1.5
        delay                       += Double(slowSpin.duration) * Double(slowSpin.repeatCount)
        
        let selectionSpin           = CABasicAnimation(keyPath: "transform.rotation")
        selectionSpin.delegate      = self
        selectionSpin.fromValue     = NSNumber(floatLiteral: 0)
        selectionSpin.toValue       = NSNumber(floatLiteral: Double(self.selectionAngle))
        selectionSpin.duration      = selectionSpinDuration
        selectionSpin.beginTime     = CACurrentMediaTime() + delay
        selectionSpin.isCumulative  = true
        selectionSpin.repeatCount   = 1
        selectionSpin.isRemovedOnCompletion = false
        selectionSpin.fillMode      = .forwards
        
        wheelView.layer.add(fastSpin, forKey: "fastAnimation")
        wheelView.layer.add(slowSpin, forKey: "SlowAnimation")
        wheelView.layer.add(selectionSpin, forKey: "SelectionAnimation")
    }
}


extension RoamWheely : CAAnimationDelegate {
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        if flag{
            performFinish(error: nil)
        } else {
            self.performFinish(error: RWErrorMessage.genericError)
        }
    }
}

extension RoamWheely {
    
    func finishedSelecting(index : Int? , error : RWErrorMessage?){
    }
}
