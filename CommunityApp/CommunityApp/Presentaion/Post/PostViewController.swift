import UIKit

class PostViewController: UIViewController {
    
    let postView = PostTextView()
    var popupButton = UIButton()
    var imageButton = UIButton()
    let imagePicker = UIImagePickerController()
    var cnt = 0
    let imageView = UIImageView()
    var imagePostArr = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
        
    }
    
    func configureUI () {
        let safeArea = view.safeAreaLayoutGuide
        
        //MARK: POPUPButton Setting
        popupButton.setTitle("게시글의 주제를 선택해 주세요", for: .normal)
        popupButton.setTitleColor(.black, for: .normal)
        popupButton.backgroundColor = .white
        popupButton.layer.borderWidth = 1
        popupButton.layer.borderColor = UIColor.black.cgColor
        
        //POPUPButton Menu
        let question = UIAction(title: "동네질문", handler: { _ in print("동네질문") })
        let localNews = UIAction(title: "동네소식", handler: { _ in print("동네소식") })
        let hobby = UIAction(title: "취미생활", handler: { _ in print("취미생활") })
        let loss = UIAction(title: "분실/실종센터", handler: { _ in print("분실/실종센터") })
        let please = UIAction(title: "해주세요", handler: { _ in print("해주세요") })
        let photo = UIAction(title: "동네사진전", handler: { _ in print("동네사진전") })
        
        let buttonMenu = UIMenu(title: "게시글의 주제를 선택해 주세요.", children: [question, localNews, hobby, loss, please, photo])
        popupButton.menu = buttonMenu
        popupButton.showsMenuAsPrimaryAction = true //누르자마자 바로 메뉴 나오게
        popupButton.changesSelectionAsPrimaryAction = true
        
        //MARK: IMAGEButton Setting
        imageButton.setImage(UIImage(systemName: "photo.artframe"), for: .normal)
        imageButton.setTitleColor(.black, for: .normal)
        imageButton.backgroundColor = .white
        imageButton.addTarget(self, action: #selector(uploadPhoto), for: .touchUpInside)
        //MARK: IMAGEButton push on keyboard toolbar
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let barImageButton = UIBarButtonItem.init(customView: imageButton)
        toolBar.items = [barImageButton]
        self.postView.textView.inputAccessoryView = toolBar
        
        
        view.addSubview(postView)
        view.addSubview(popupButton)
        view.addSubview(imageView)
        
        postView.translatesAutoresizingMaskIntoConstraints = false
        popupButton.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            //PostView
            postView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            postView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            postView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            postView.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            
            //Popupbutton
            popupButton.topAnchor.constraint(equalTo: safeArea.topAnchor),
            popupButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            popupButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            popupButton.heightAnchor.constraint(equalToConstant: 50),
            
            //imageView
            imageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 50),
            imageView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -50),
            imageView.topAnchor.constraint(equalTo: popupButton.bottomAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 150)
            
            
        ])
        
        
    }
    
    
    @objc func uploadPhoto() {
        actionSheetAlert()
    }
    
}


extension PostViewController : UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    
    func actionSheetAlert(){
        
        let alert = UIAlertController(title: "선택", message: "선택", preferredStyle: .actionSheet)
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        let camera = UIAlertAction(title: "카메라", style: .default) { [weak self] (_) in
            self?.presentCamera()
        }
        let album = UIAlertAction(title: "앨범", style: .default) { [weak self] (_) in
            self?.presentAlbum()
        }
        
        alert.addAction(cancel)
        alert.addAction(camera)
        alert.addAction(album)
        present(alert, animated: true, completion: nil)
        
    }
    
    func presentCamera(){
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        vc.cameraFlashMode = .on
        present(vc, animated: true, completion: nil)
    }
    
    func presentAlbum(){
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("picker -> \(String(describing: info[UIImagePickerController.InfoKey.imageURL]))")
   
        if cnt % 2 == 0 {
            if let image = info[.editedImage] as? UIImage {
                imageView.image = image
                imagePostArr.append(image)
            }
        }
        else{
            if let image = info[.originalImage] as? UIImage {
                imageView.image = image
                imagePostArr.append(image)
            }
        }
        
        cnt += 1
        print(cnt)
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
