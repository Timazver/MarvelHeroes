//
//  ChatViewController.swift
//  MarvelHeroes
//
//  Created by tima on 1/16/20.
//  Copyright © 2020 MarvelHeroes. All rights reserved.
//

import UIKit
import RxSwift

private enum Constants {
    static let incomingMessageCell = "incomingMessageCell"
    static let outgoingMessageCell = "outgoingMessageCell"
    static let contentInset: CGFloat = 24
    static let placeholderMessage = "Type something"
}

class ChatViewController: UIViewController {
    var chat = Chat()
    var disposeBag = DisposeBag()
    var messages = [Message]()
    {
        didSet {
            emptyChatView.isHidden = !messages.isEmpty
            tableView.reloadData()
        }
    }
    var viewModel = ChatViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textAreaBackground: UIView!
    @IBOutlet weak var textAreaBottom: NSLayoutConstraint!
    @IBOutlet weak var emptyChatView: UIView!
    
    @IBAction func onSendButtonTapped(_ sender: Any) {
        sendMessage()
        answerMessage()
    }
    
    private func sendMessage() {
        let message = Message()
        message.author = "Me"
        guard !textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return
        }
        message.text = textView.text
        message.isIncoming = false
        messages.append(message)
        textView.endEditing(true)
        addTextViewPlaceholer()
        scrollToLastCell()
    }
    
    private func answerMessage() {
        messages.append(MessageAnswer.randomMessageAnswer(author: chat.name))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emptyChatView.isHidden = false
        setUpTableView()
        setUpTextView()
        startObservingKeyboard()
        tableView.dataSource = self
        setupBindings()
        viewModel.getChat(name: chat.name)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addTextViewPlaceholer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        for item in self.messages {
            chat.messages.append(item)
        }
        viewModel.saveChat(chat: chat)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Add default shadow to navigation bar
        let navigationBar = navigationController?.navigationBar
        navigationBar?.shadowImage = nil
    }
    
    private func startObservingKeyboard() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(
            forName: UIResponder.keyboardWillShowNotification,
            object: nil,
            queue: nil,
            using: keyboardWillAppear)
        notificationCenter.addObserver(
            forName: UIResponder.keyboardWillHideNotification,
            object: nil,
            queue: nil,
            using: keyboardWillDisappear)
    }
    
    deinit {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(
            self,
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        notificationCenter.removeObserver(
            self,
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
    
    private func keyboardWillAppear(_ notification: Notification) {
        let key = UIResponder.keyboardFrameEndUserInfoKey
        guard let keyboardFrame = notification.userInfo?[key] as? CGRect else {
            return
        }
        
        let safeAreaBottom = view.safeAreaLayoutGuide.layoutFrame.maxY
        let viewHeight = view.bounds.height
        let safeAreaOffset = viewHeight - safeAreaBottom
        
        let lastVisibleCell = tableView.indexPathsForVisibleRows?.last
        
        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            options: [.curveEaseInOut],
            animations: {
                self.textAreaBottom.constant = -keyboardFrame.height + safeAreaOffset
                self.view.layoutIfNeeded()
                if let lastVisibleCell = lastVisibleCell {
                    self.tableView.scrollToRow(
                        at: lastVisibleCell, at: .bottom, animated: false)
                }
        })
    }
    
    private func keyboardWillDisappear(_ notification: Notification) {
        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            options: [.curveEaseInOut],
            animations: {
                self.textAreaBottom.constant = 0
                self.view.layoutIfNeeded()
        })
    }
    
    private func setUpTextView() {
        textView.isScrollEnabled = false
        textView.textContainer.heightTracksTextView = true
        textView.delegate = self
        
        textAreaBackground.layer.addShadow(
            color: UIColor(red: 189 / 255, green: 204 / 255, blue: 215 / 255, alpha: 54 / 100),
            offset: CGSize(width: 2, height: -2),
            radius: 4)
    }
    
    private func setUpTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: Constants.contentInset, left: 0, bottom: 0, right: 0)
        tableView.allowsSelection = false
    }
    
    private func setupBindings() {
        
        viewModel.currentChat.subscribe(onNext: { chat in
            for item in chat.messages {
                self.messages.append(item)
            }
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }
}

extension ChatViewController: UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let message = messages[indexPath.row]
        let cellIdentifier = message.isIncoming ?
            Constants.incomingMessageCell :
            Constants.outgoingMessageCell
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: cellIdentifier, for: indexPath)
            as? MessageCell & UITableViewCell else {
                return UITableViewCell()
        }
        cell.message = message
        
        if indexPath.row < messages.count - 1 {
            let nextMessage = messages[indexPath.row + 1]
            cell.showsAvatar = message.isIncoming != nextMessage.isIncoming
        } else {
            cell.showsAvatar = true
        }
        
        return cell
    }
    
    private func scrollToLastCell() {
        let lastRow = tableView.numberOfRows(inSection: 0) - 1
        guard lastRow > 0 else {
            return
        }
        
        let lastIndexPath = IndexPath(row: lastRow, section: 0)
        tableView.scrollToRow(at: lastIndexPath, at: .bottom, animated: true)
    }
}

extension ChatViewController: UITextViewDelegate {
    private func addTextViewPlaceholer() {
        textView.text = Constants.placeholderMessage
        textView.textColor = .placeholderBody
    }
    
    private func removeTextViewPlaceholder() {
        textView.text = ""
        textView.textColor = .darkBody
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        removeTextViewPlaceholder()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            addTextViewPlaceholer()
        }
    }
}
