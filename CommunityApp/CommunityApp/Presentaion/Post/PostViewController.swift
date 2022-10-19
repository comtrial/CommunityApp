import UIKit

class PostViewController: UIViewController {

    let postView = PostTextView()
    var popupButton = UIButton()
    var imageButton = UIButton()
//    let imagePicker = UIImagePickerController()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
//        imagePickerSetting()
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
        
        //MARK: IMAGEButton push on keyboard toolbar
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let barImageButton = UIBarButtonItem.init(customView: imageButton)
        toolBar.items = [barImageButton]
        self.postView.textView.inputAccessoryView = toolBar
        
        
        view.addSubview(postView)
        view.addSubview(popupButton)

        postView.translatesAutoresizingMaskIntoConstraints = false
        popupButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
           //MARK: PostView
            postView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            postView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            postView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            postView.topAnchor.constraint(equalTo: view.topAnchor, constant: 175),

           //MARK: Popupbutton
            popupButton.bottomAnchor.constraint(equalTo: postView.topAnchor),
            popupButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            popupButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            popupButton.heightAnchor.constraint(equalToConstant: 50)

           
        ])


    }

    //MARK: ImagePicker
//    func imagePickerSetting() {
//        self.imagePicker.sourceType = .photoLibrary // 앨범에서 가져옴
//            self.imagePicker.allowsEditing = true // 수정 가능 여부
//            self.imagePicker.delegate = self // picker delegate
//    }

}

//extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//            imageView.contentMode = .scaleAspectFit
//            imageView.image = pickedImage //4
//        }
//        dismiss(animated: true, completion: nil)
//    }
//
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        dismiss(animated: true, completion: nil)
//    }
//}
