//
//  ChatController.swift
//  Hackathon_UET
//
//  Created by Tuan Vu on 3/12/17.
//  Copyright © 2017 Anh Tuan. All rights reserved.
//

import UIKit

class ChatController: JSQMessagesViewController {
    
    private var messages : [JSQMessage] = []
    
    lazy var outgoingBubbleImageView: JSQMessagesBubbleImage = self.setupOutgoingBubble()
    lazy var incomingBubbleImageView: JSQMessagesBubbleImage = self.setupIncomingBubble()
    
    private func setupOutgoingBubble() -> JSQMessagesBubbleImage {
        let bubbleImageFactory = JSQMessagesBubbleImageFactory()
        return bubbleImageFactory!.outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleBlue())
    }
    
    private func setupIncomingBubble() -> JSQMessagesBubbleImage {
        let bubbleImageFactory = JSQMessagesBubbleImageFactory()
        return bubbleImageFactory!.incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleLightGray())
    }
    
    var groupId : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.senderId = UltilsUser.userId
        self.senderDisplayName = UltilsUser.kUserName
        
        self.edgesForExtendedLayout = []
        self.inputToolbar.contentView.textView.placeHolder = "cùng trò chuyện!"
        self.inputToolbar.contentView.textView.layer.borderColor = UIColor.clear.cgColor
        
     
            FirebaseAPI.loadGroupsMessage(grId: self.groupId) { (listMess) in
                
                for mess in listMess
                {
                    let message = JSQMessage(senderId: mess.messageUserId, senderDisplayName: mess.messageUserDisplayName, date: Helper.milisecondsToDateTime(miliSecs: mess.messageDate), text: mess.messageText)
                    self.messages.append(message!)
                }
                
                self.collectionView.reloadData()
                
            }
     
        
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
    }
    
    private func setupNavibarButton()
    {
        let backButton = UIBarButtonItem(image: UIImage(named:"back")?.withRenderingMode(.alwaysTemplate), landscapeImagePhone: UIImage(named:"back"), style: .plain, target: self, action: #selector(backButtonDidTap))
        backButton.setTitleTextAttributes([NSFontAttributeName : UIFont.systemFont(ofSize: 12) ,NSForegroundColorAttributeName : UIColor.white ], for: .normal)
        backButton.tintColor = .white
        navigationItem.leftBarButtonItem = backButton
    }
    
    func backButtonDidTap()
    {
        dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        
        let message = JSQMessage(senderId: senderId, senderDisplayName: senderDisplayName, date: date, text: text)
        //        self.messages.append(message!)
        let messToSend = Message()
        messToSend.deleteFlag = 0
        messToSend.messageOrder = 1
        messToSend.messageText = text
        messToSend.messageUserId = self.senderId
        messToSend.messageUserDisplayName = senderDisplayName
        messToSend.messageDate = Helper.dateToMiliSecs(date: date)
        messToSend.messageUserAvatarUrl = ""
        messToSend.messageType = 1
        
        FirebaseAPI.sendMessageToFirebase(grId: self.groupId, mess:messToSend)
        
        
        JSQSystemSoundPlayer.jsq_playMessageSentSound()
        finishSendingMessage()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.messages.count
        
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        
        return self.messages[indexPath.item]
        
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, didDeleteMessageAt indexPath: IndexPath!) {
        
    }

    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        
        let message = self.messages[indexPath.item]
        if message.senderId == senderId {
            return outgoingBubbleImageView
        } else {
            return incomingBubbleImageView
        }
        
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        
        let message = self.messages[indexPath.item]
        let factoryImg  = JSQMessagesAvatarImageFactory.circularAvatarImage(UIImage(named:"f_avatar.png"), withDiameter: UInt(kJSQMessagesCollectionViewAvatarSizeDefault))
        let avatar  = JSQMessagesAvatarImage.init(placeholder: UIImage())
        avatar?.avatarImage = factoryImg
        
        if message.senderId == senderId {
            
            return nil
        } else {
            
            return avatar
        }
        
    }
    
    
    override func didPressAccessoryButton(_ sender: UIButton!) {
        
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! JSQMessagesCollectionViewCell
        cell.textView.font = UIFont.systemFont(ofSize: 14)
        
        let message = self.messages[indexPath.item]
        
        if message.senderId == senderId {
            cell.textView?.textColor = UIColor(red: 52/255, green: 52/255, blue: 52/255, alpha: 1)
            cell.cellBottomLabel.textAlignment = .left
            
            
        } else {
            cell.textView?.textColor =  UIColor.white
            cell.cellBottomLabel.textAlignment = .right
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForCellBottomLabelAt indexPath: IndexPath!) -> CGFloat {
        
        return 30
    }

    
    
    
    
    
    
    
    
    


}
