import UIKit

class MyViewController: UIViewController {
    private var reCAPTCHAViewModel: ReCAPTCHAViewModel?
    private var vm: ReCAPTCHAViewModel!
    private var vc: ReCAPTCHAViewController!
    
    private var usePush = true
    
    override func viewDidLoad() {

        super.viewDidLoad()
        
        let button = UIButton(type: .system)
        
        button.setTitle("Show reCapcha", for: .normal)
        button.addTarget(self, action: #selector(showRecapcha), for: .touchUpInside)
        button.frame = self.view.frame
        self.view.addSubview(button)
        
        let viewModel = ReCAPTCHAViewModel(
            siteKey: "Site Key",
            url: URL(string: "URL")!
        )

        viewModel.delegate = self
        self.vm = viewModel
        
        showRecapcha()
  }
    
    @objc func showRecapcha() {
        self.usePush = Int.random(in: 0..<2)%2==0
        
        let vc = ReCAPTCHAViewController(viewModel: self.vm)
        self.vc = vc
        
        if usePush {
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            self.present(vc, animated: true, completion: nil)
        }
    }
    
}

// MARK: - ReCAPTCHAViewModelDelegate
extension MyViewController: ReCAPTCHAViewModelDelegate {
    func didSolveCAPTCHA(token: String) {
        print("Token: \(token)")
        
        if usePush {
            self.navigationController?.popViewController(animated: true)
        } else {
            self.vc.dismiss(animated: true, completion: nil)
        }
    }
}
