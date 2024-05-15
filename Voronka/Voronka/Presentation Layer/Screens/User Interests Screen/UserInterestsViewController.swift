//
//  UserInterestsViewController2.swift
//  Voronka
//
//  Created by Ирлан Абушахманов on 19.04.2023.
//

import UIKit

import TagListView

final class UserInterestsViewController: UIViewController {    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = AppConstants.Design.Color.Primary.Black
        fetchInterestGroupsOfTags { [weak self] groups in
            if groups.isEmpty {
                // TODO: add error popup.
            }
            DispatchQueue.main.async {
                self?.groups = groups
                self?.setup()
            }
        }
    }
    
    private var isRegistration = true
    internal var groups: [UserInterestGroupsViewModel] = []
    
    internal let categoriesTagList = TagListView()
    internal let toSelectTagList = TagListView()
    internal let chosenTagList = TagListView()
    
    internal let chosenScroll = UIScrollView()
    internal let dropTagsButton = UIButton()
    internal let youHaveChosenLabel = UILabel()
    
    internal lazy var toSelectDelegate = ToSelectDelegate(viewController: self)
    internal lazy var categoriesDelegate = CategoriesDelegate(viewController: self)
    internal lazy var chosenDelegate = ChosenDelegate(viewController: self)
    
    internal let maxTagsAmount: Int = 10
    
    internal var chosenInterests = [String]()    
    
    internal let tellAboutInterestsLabel = HeaderScreenTitle(
        configuration: .init(
            text: """
            Расскажите о своих
            интересах
            """,
            numberOfLines: 2
        ),
        appearance: .common
    )
    
    internal let endButton = LabeledButton(
        configuration: .init(title: "Завершить", state: .disabled),
        appearance: .common
    )
    
    internal let underlinedViews = UnderlinedViewsStack(
        configuration: .init(viewsAmount: 2, viewsStates: [.selected, .selected]),
        appearance: .common
    )
    
    private func setup() {
        categoriesTagList.addTags(groups.map{ $0.name })
        setupAppearance()
        setupConstraints()
    }
    
    private func fetchInterestGroupsOfTags(completion: @escaping ([UserInterestGroupsViewModel]) -> Void) {
        var str = "ru"
        if #available(iOS 16, *), Locale.current.language.languageCode == "en" || Locale.current.languageCode == "en" {
            str = "en"
        }
        guard let url = URL(
            string: "https://voronka-events.ru/api/v1/utils/category/get-\(str)"
        ) else { return }
        
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)
        session.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let decodedData = try JSONDecoder().decode([TagCategoriesModel].self, from: data)
                let results = decodedData.compactMap({ item in
                    return UserInterestGroupsViewModel(
                        id: item.categoryId ?? 0,
                        name: item.title ?? "",
                        tags: item.tags?.compactMap({
                            return Tag(
                                id: $0.tagId ?? 0,
                                title: $0.title ?? ""
                            )
                        }) ?? []
                    )
                })
                completion(results)
            } catch {
                completion([])
            }
        }.resume()
    }
    
    public func updateYouHaveChosenLabelText() {
        let newLabelText = "Вы выбрали \(chosenInterests.count)/\(maxTagsAmount):"
        youHaveChosenLabel.text = newLabelText
    }
    
    public func checkButton() {
        endButton.buttonState = chosenInterests.count >= 5 ? .enabled : .disabled
    }
    
    public func configure(isRegistration: Bool) {
        self.isRegistration = isRegistration
    }
    
    private func highlightChosenTags() {
        var selectedTags: [Tag]? = []
        let selectedTagsIds = UserDefaults.standard.array(forKey: AppConstants.UserDefaultsKeys.Tags) as! [Int]
        for group in groups {
            for tag in group.tags {
                if selectedTagsIds.contains(tag.id) && !(selectedTags?.contains(where: { $0.id == tag.id }) ?? true) {
                    selectedTags?.append(tag)
                }
            }
        }
        DispatchQueue.main.async {
            for tag in selectedTags! {
                self.toSelectDelegate.tagPressed(tag.title, tagView: TagView(title: tag.title), sender: TagListView())
            }
        }
    }
    
    @objc internal func deleteAllChose() {
        chosenTagList.removeAllTags()
        toSelectTagList.tagViews.forEach {
            $0.isSelected = false
        }
        chosenInterests = []
        updateYouHaveChosenLabelText()
        endButton.buttonState = .disabled
    }
    
    @objc internal func endButtonPressed() {
        navigationController?.fadeTo(RegistrationFinishViewController())
    }
}

final class CategoriesDelegate: TagListViewDelegate {
    weak var viewController: UserInterestsViewController?
    
    init(viewController: UserInterestsViewController) {
        self.viewController = viewController
    }
    
    internal func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        guard let controller = viewController else { return }
        
        let selected = sender.tagViews.first{ $0.isSelected }
        guard tagView != selected else { return }
        
        sender.tagViews.forEach { tag in
            tag.resetSelection()
        }
        
        tagView.isSelected.toggle()
        if (tagView.isSelected) {
            tagView.categoriesSelected()
        }
     
        controller.toSelectTagList.removeAllTags()
        
        if let selectedTag = controller.groups.first(where: { $0.name == title}) {
            controller.toSelectTagList.addTags(selectedTag.tags.map{ $0.title})
            
            controller.toSelectTagList.tagViews.forEach {
                if controller.chosenInterests.contains($0.title) {
                    $0.isSelected = true
                    $0.interestSelected()
                }
            }
        }
    }
}

final class ToSelectDelegate: TagListViewDelegate {
    weak var viewController: UserInterestsViewController?

    init(viewController: UserInterestsViewController) {
        self.viewController = viewController
    }
    
    internal func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        guard let controller = viewController else { return }

        if !tagView.isSelected && controller.chosenInterests.count == controller.maxTagsAmount {
            return
        }
        
        
        tagView.isSelected.toggle()
        tagView.interestSelected()
        
        if (tagView.isSelected) {
            controller.chosenInterests.append(title)
            controller.chosenTagList.addTag(title)
        } else {
            controller.chosenTagList.removeTag(title)
            controller.chosenInterests.removeAll(where: { $0 == title} )
        }
        
        controller.updateYouHaveChosenLabelText()
        controller.checkButton()
    }
}

final class ChosenDelegate: TagListViewDelegate {
    weak var viewController: UserInterestsViewController?

    init(viewController: UserInterestsViewController) {
        self.viewController = viewController
    }
    
    internal func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        guard let controller = viewController else { return }

        sender.removeTag(title)
        controller.toSelectTagList.tagViews.first(where: { $0.title == title})?.isSelected = false
        controller.chosenInterests.removeAll(where: { $0 == title} )
        controller.updateYouHaveChosenLabelText()
        tagView.interestSelected()
        controller.checkButton()
    }
}

extension UserInterestsViewController: URLSessionDelegate {
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        if challenge.protectionSpace.host == "voronka-events.ru" {
            completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
        } else {
            completionHandler(.performDefaultHandling, nil)
        }
    }
}
