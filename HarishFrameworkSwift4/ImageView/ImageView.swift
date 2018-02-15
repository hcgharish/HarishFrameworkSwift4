//
//  ImageView.swift
//  HarishFrameworkSwift4
//
//  Created by Harish on 11/01/18.
//  Copyright © 2018 Harish. All rights reserved.
//

import UIKit

open class ImageView: UIImageView, LayoutParameters {
    func mandatory() {}
    
    var isMandatory: Bool = false
    
    var classPara: ClassPara = ClassPara()
    
    @IBInspectable open var isBorder: Bool = false
    
    @IBInspectable open var border: Int = 0
    
    @IBInspectable open var radious: Int = 0
    
    @IBInspectable open var borderColor: UIColor? = nil
    
    @IBInspectable open var isShadow: Bool = false
    
    @IBInspectable open var shadow_Color: UIColor? = UIColor.darkGray
    
    @IBInspectable open var ls_Opacity:CGFloat = 0.5
    @IBInspectable open var ls_Radius:Int = 0
    
    @IBInspectable open var lsOff_Width:CGFloat = 2.0
    @IBInspectable open var lsOff_Height:CGFloat = 2.0
    
    @IBInspectable open var isStrokeColor: Bool = false
    
    var shadowLayer: CAShapeLayer!
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        let ob = ClassPara ()
        
        ob.shadowLayer = shadowLayer
        ob.backgroundColor = backgroundColor
        ob.layer = layer
        
        classPara = ob
        
        layoutSubviews (self)
    }
    
    var url:[String] = []
    
    @IBInspectable open var willZoom: Bool = false
    @IBInspectable open var background_color: UIColor = UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5)
    
    override open func draw(_ rect: CGRect) {
        setUIImage ()
        
        if willZoom {
            addClickButton (rect)
        }
        
        if isStrokeColor {
            strokeColor()
        }
    }
    
    open func willZoomImage (_ image:UIImage) {
        willZoom = true
        self.image = image
        
        self.createZoomView(superView)
        
        if willZoom {
            addClickButton (self.frame)
        }
    }
    
    var urlImage:String? = nil
    var dImage:String? = nil
    var boolScal:Bool = false
    var ai:UIActivityIndicatorView? = nil
    var superView:UIView? = nil
    
    public func setImage(_ superView:UIView?, _ urlImage:String?, _ dImage:String?, _ boolScal:Bool, _ ai:UIActivityIndicatorView?) {
        draw (self.frame)
        
        self.superView = superView
        self.urlImage = urlImage
        self.dImage = dImage
        self.boolScal = boolScal
        self.ai = ai
        
        setUIImage ()
    }
    
    public func createZoomView (_ superView:UIView?) {
        if willZoom {
            DispatchQueue.main.async {
                self.superView = superView
                self.addClickButton (self.frame)
            }
        }
    }
    
    public func setUIImage () {
        if urlImage != nil {
            self.uiimage(urlImage, dImage, boolScal, ai)
        }
    }
    
    var btnOpen:UIButton? = nil
    
    public func addClickButton (_ rect: CGRect) {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped(_ :)))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc public func imageTapped (_ tapGestureRecognizer: UITapGestureRecognizer) {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        openZoomView(tappedImage)
    }
    
    public func openZoomView (_ sender:Any) {
        if viewZoomContainer == nil {
            viewZoomContainer = UIView()
            viewZoomContainer?.frame = UIScreen.main.bounds
            viewZoomContainer?.isUserInteractionEnabled = true
            
            viewZoomContainer?.backgroundColor = background_color
            
            if scZoom == nil {
                scZoom = UIScrollView()
                scZoom?.frame = UIScreen.main.bounds
                scZoom?.isUserInteractionEnabled = true
                viewZoomContainer?.addSubview(scZoom!)
            }
            
            if imgZoom == nil {
                imgZoom = UIImageView()
                imgZoom?.isUserInteractionEnabled = true
                
                if scZoom != nil {
                    scZoom?.addSubview(imgZoom!)
                    addPichZoom ()
                }
            }
            
            if btnRemoveZoomaContainer == nil {
                let frame = CGRect(x: 0.0, y: 10.0, width: 50, height: 50)
                btnRemoveZoomaContainer = UIButton(frame: frame)
                btnRemoveZoomaContainer?.setTitle("X", for: UIControlState.normal)
                btnRemoveZoomaContainer?.titleLabel?.font = UIFont.systemFont(ofSize: 20)
                btnRemoveZoomaContainer?.setTitleColor(UIColor.red, for: UIControlState.normal)
                
                btnRemoveZoomaContainer?.addTarget(self, action: #selector(actionRemoveZoomContainer (_ :)), for: UIControlEvents.touchUpInside)
                
                viewZoomContainer?.addSubview(btnRemoveZoomaContainer!)
            }
            
            DispatchQueue.main.async {
                let image = self.image
                
                if image != nil {
                    
                    self.imgZoom?.image = image
                    
                    let size = getImageSizeByUIScreen((image?.size)!)
                    
                    var frame = self.imgZoom?.frame
                    frame?.origin.x = (self.viewZoomContainer?.frame.size.width)! / 2 - size.width / 2
                    frame?.origin.y = (self.viewZoomContainer?.frame.size.height)! / 2 - size.height / 2
                    frame?.size.width = size.width
                    frame?.size.height = size.height
                    self.imgZoom?.frame = frame!
                    self.frameImage = frame
                }
            }
        } else {
            if frameImage != nil {
                self.imgZoom?.frame = frameImage!
                
                makeInCenter (true)
            }
        }
        
        var superView = self.superview
        
        while (true) {
            if superView is UIWindow {
                superView?.addSubview(viewZoomContainer!)
                break
            } else {
                superView = superView?.superview
            }
        }
    }
    
    var frameImage:CGRect? = nil
    
    @IBOutlet var scZoom: UIScrollView? = nil
    var viewZoomContainer: UIView? = nil
    var imgZoom: UIImageView? = nil
    var twoFingerPinch:UIPinchGestureRecognizer? = nil
    
    var superClass:Any? = nil
    
    @IBOutlet var btnRemoveZoomaContainer:UIButton? = nil
    
    @IBAction public func actionRemoveZoomContainer(_ sender: Any) {
        viewZoomContainer?.removeFromSuperview()
    }
    
    public func addPichZoom () {
        twoFingerPinch = UIPinchGestureRecognizer(target: self, action: #selector(self.twoFingerPinch(_ :)))
        imgZoom?.addGestureRecognizer(twoFingerPinch!)
    }
    
    @objc public func twoFingerPinch (_ recognizer:UIPinchGestureRecognizer) {
        let scale: CGFloat = recognizer.scale;
        
        imgZoom?.transform = (imgZoom?.transform.scaledBy(x: scale, y: scale))!;
        recognizer.scale = 1.0;
        
        makeInCenter (false)
    }
    
    func makeInCenter (_ boolCenter:Bool) {
        var width = viewZoomContainer?.frame.size.width
        var height = viewZoomContainer?.frame.size.height
        
        if (imgZoom?.frame.size.width)! > (viewZoomContainer?.frame.size.width)! && (imgZoom?.frame.size.height)! > (viewZoomContainer?.frame.size.height)! {
            width = imgZoom?.frame.size.width
            height = imgZoom?.frame.size.height
        } else if (imgZoom?.frame.size.width)! > (viewZoomContainer?.frame.size.width)! {
            width = imgZoom?.frame.size.width
        } else if (imgZoom?.frame.size.height)! > (viewZoomContainer?.frame.size.height)! {
            height = imgZoom?.frame.size.height
        }
        
        
        scZoom?.contentSize = CGSize(width:width!, height:height!)
        imgZoom?.center = CGPoint(x: (scZoom?.contentSize.width)! / 2, y: (scZoom?.contentSize.height)! / 2)
        scZoom?.contentOffset = CGPoint(x: (imgZoom?.center.x)! - (scZoom?.frame.size.width)! / 2, y: (imgZoom?.center.y)! - (scZoom?.frame.size.height)! / 2)
    }
}

public extension UIImageView {
    public func saveImageDocumentDirectory() {
        let fileManager = FileManager.default
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("apple.jpg")
        let image = UIImage(named: "apple.jpg")
        print(paths)
        let imageData = UIImageJPEGRepresentation(image!, 0.5)
        fileManager.createFile(atPath: paths as String, contents: imageData, attributes: nil)
    }
    
    public func getDirectoryPath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    public func getImage () -> UIImage? {
        let fileManager = FileManager.default
        let imagePAth = (self.getDirectoryPath() as NSString).appendingPathComponent("apple.jpg")
        
        if fileManager.fileExists(atPath: imagePAth) {
            return UIImage(contentsOfFile: imagePAth)
        } else {
            return nil
        }
    }
    
    public func createDirectory() {
        let fileManager = FileManager.default
        
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("customDirectory")
        
        if !fileManager.fileExists(atPath: paths) {
            try! fileManager.createDirectory(atPath: paths, withIntermediateDirectories: true, attributes: nil)
        } else {
            print("Already dictionary created.")
        }
    }
    
    public func deleteDirectory(){
        let fileManager = FileManager.default
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("customDirectory")
        
        if !fileManager.fileExists(atPath: paths) {
            try! fileManager.removeItem(atPath: paths)
        } else {
            print("Something wronge.")
        }
    }
    
    public func deleteFileForUrl (_ url:String?) {
        let fileManager = FileManager.default
        let imagePAth = (self.getDirectoryPath() as NSString).appendingPathComponent(url!.imageName())
        
        let del:Bool = fileManager.fileExists(atPath: imagePAth)
        
        if del {
            try! fileManager.removeItem(atPath: imagePAth)
        } else {
            print("Something wronge.")
        }
    }
    
    public func savedUIImageForUrl (_ url:String, block: @escaping (UIImage?) -> Swift.Void) {
        let fileManager = FileManager.default
        let imagePAth = (self.getDirectoryPath() as NSString).appendingPathComponent(url.imageName())
        
        if fileManager.fileExists(atPath: imagePAth) {
            block(UIImage(contentsOfFile: imagePAth))
        } else {
            block(nil)
        }
    }
    
    public func savedUIImage (_ name:String?, block: @escaping (UIImage?) -> Swift.Void) {
        
        if (name == nil) {
            block(nil)
        } else {
            let fileManager = FileManager.default
            let imagePAth = (self.getDirectoryPath() as NSString).appendingPathComponent(name!)
            
            if fileManager.fileExists(atPath: imagePAth) {
                block(UIImage(contentsOfFile: imagePAth))
            } else {
                block(nil)
            }
        }
    }
    
    public func saveUIImage (_ name:String?, _ img:UIImage?) {
        if (name != nil && img != nil) {
            let data:Data? = UIImagePNGRepresentation(img!)!
            
            if (data != nil) {
                let fileManager = FileManager.default
                let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(name!)
                
                fileManager.createFile(atPath: paths as String, contents: data, attributes: nil)
            }
        }
    }
    
    public func saveUIImageForUrl (_ url:String?, _ img:UIImage?) {
        if (url != nil && img != nil) {
            let data:Data? = UIImagePNGRepresentation(img!)!
            
            if (data != nil) {
                let fileManager = FileManager.default
                let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(url!.imageName())
                
                fileManager.createFile(atPath: paths as String, contents: data, attributes: nil)
            }
        }
    }
    
    @objc public func displayImage (_ dict:NSDictionary) {
        DispatchQueue.main.async {
            let boolCustomScale:Bool = dict["scale"] as! Bool
            
            if (boolCustomScale) {
                self.clipsToBounds = true;
                self.contentMode = .scaleAspectFill
            }
            
            let url:String = dict["url"] as! String
            
            let imgV = self as? ImageView
            
            if imgV != nil {
                let superView = dict["superView"] as? UIView
                
                if (imgV?.url.count)! > 0 {
                    if imgV != nil {
                        
                        let imageUrl = imgV?.url[(imgV?.url.count)!-1]
                        
                        if imageUrl != nil {
                            if imageUrl! == url {
                                if let img = dict["image"] as? UIImage {
                                    self.image = img
                                    imgV?.createZoomView(superView)
                                } else if let dimg = dict["dimage"] as? String {
                                    self.image = UIImage(named: dimg)
                                }
                            }
                        }
                    } else {
                        if let img = dict["image"] as? UIImage {
                            self.image = img
                            imgV?.createZoomView(superView)
                        } else if let dimg = dict["dimage"] as? String {
                            self.image = UIImage(named: dimg)
                        }
                    }
                }
            } else {
                if let img = dict["image"] as? UIImage {
                    self.image = img
                } else if let dimg = dict["dimage"] as? String {
                    self.image = UIImage(named: dimg)
                }
            }
            
            if let ai = dict["ai"] as? UIActivityIndicatorView {
                ai.isHidden = true
                ai.stopAnimating()
            }
        }
    }
    
    public func downloadUIImage (_ url:String?, block: @escaping (UIImage?) -> Swift.Void) {
        let md = NSMutableDictionary()
        md["url"] = url
        md["block"] = block
        
        self.performSelector(inBackground: #selector(downloadUIImageThread (_ :)), with: md)
    }
    
    @objc public func downloadUIImageThread (_ md:NSMutableDictionary) {
        let url:String? = md["url"] as? String
        let block = md["block"] as! (UIImage?) -> Swift.Void
        
        self.savedUIImageForUrl(url!, block: { (img) in
            if (img != nil) {
                block(img)
            } else {
                let urlL = URL(string: (url?.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)!)!)!
                
                let data = NSData(contentsOf: urlL as URL) as Data?
                
                var image:UIImage? = nil;
                
                if (data != nil) {
                    image = UIImage(data: data! as Data)
                    
                    if (image != nil) {
                        self.saveUIImageForUrl(url, image)
                    }
                } else {
                    self.deleteFileForUrl(url)
                }
                
                block(image)
            }
        })
    }
    
    public func uiimage (_ url:String?, _ dImage:String?, _ boolScal:Bool, _ ai:UIActivityIndicatorView?, _ superView:UIView? = nil) {
        if url != nil {
            if ((url?.count)! > 0 && url != "") {
                savedUIImageForUrl(url!, block: { (image) in
                    if image != nil {
                        self.image = image
                        
                        if superView != nil {
                            let imgV = self as? ImageView
                            
                            if imgV != nil {
                                imgV?.createZoomView(superView)
                            }
                        }
                    } else {
                        self.image = UIImage()
                        
                        if self is ImageView {
                            let iiii = self as? ImageView
                            iiii?.url.append(url!)
                        }
                        
                        if ai != nil {
                            ai?.isHidden = false
                            ai?.startAnimating()
                        }
                        
                        var dImage = dImage
                        
                        if (dImage == nil) {
                            dImage = "noimage.jpg";
                        } else if (dImage?.count == 0) {
                            dImage = "noimage.jpg";
                        }
                        
                        let url = url?.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)!
                        
                        let dict = NSMutableDictionary()
                        
                        dict["url"] = url
                        dict["scale"] = boolScal
                        
                        if ai != nil {
                            dict["ai"] = ai;
                        }
                        
                        dict["dimage"] = dImage
                        
                        if superView != nil {
                            dict["superView"] = superView
                        }
                        
                        self.performSelector(inBackground: #selector(self.getNSetUIImagee(_ :)), with: dict)
                    }
                })
            } else {
                self.image = UIImage(named: dImage!)
                
                if superView != nil {
                    let imgV = self as? ImageView
                    
                    if imgV != nil {
                        imgV?.createZoomView(superView)
                    }
                }
                
                if ai != nil {
                    ai?.isHidden = true
                    ai?.stopAnimating()
                }
            }
        }
    }
    
    @objc public func getNSetUIImagee (_ dict:NSDictionary) {
        let url:String = dict["url"] as! String
        
        self.downloadUIImage(url) { (image) in
            let dt = NSMutableDictionary()
            
            for (key, value) in dict {
                dt[key] = value
            }
            
            if (image != nil) {
                dt["image"] = image
            }
            
            if let superView = dict["superView"] as? UIView {
                dt["superView"] = superView
            }
            
            self.performSelector(inBackground: #selector(self.displayImage(_:)), with: dt)
        }
    }
}
