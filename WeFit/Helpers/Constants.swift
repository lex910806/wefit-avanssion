//
//  Constants.swift
//  WeFit
//
//  Created by JiHoon Lee on 2020/10/09.
//

import Firebase

let COLLECTION_MESSAGES = Firestore.firestore().collection("messages")
let COLLECTION_USERS = Firestore.firestore().collection("users")
let COLLECTION_MATCH = Firestore.firestore().collection("match")
let COLLECTION_DURINGMATCH = Firestore.firestore().collection("during-match")
let CHAT_WORKOUT_PICKER_HEIGHT: CGFloat = 216
