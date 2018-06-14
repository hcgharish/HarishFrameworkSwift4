//
//  Classes.swift
//  Cloud Market
//
//  Created by Avinash somani on 21/01/17.
//  Copyright © 2017 Kavyasoftech. All rights reserved.
//

import UIKit

class Classes: NSObject {
    
}

class friendList {
    var date:String = ""
    var email:String = ""
    var first_name:String = ""
    var friend_id:String = ""
    var id:String = ""
    var image:String = ""
    var last_name:String = ""
    var time:String = ""
    var user_id:String = ""
    var status:String = ""
    var setMe = false
}

class SearchFriends {
    var  email:String = ""
    var first_name:String = ""
    var id:String = ""
    var image:String = ""
    var last_name:String = ""
    var friend:Bool = false
   }

class GetFriendRequest {
    var date:String = ""
    var email:String = ""
    var first_name:String = ""
    var friend_id:String = ""
    var id:String = ""
    var image:String = ""
    var last_name:String = ""
    var time:String = ""
    var user_id:String = ""
    var status:String = ""
    var type:String = ""
    var event_id:String = ""
    var name:String = ""
    var joined_id:String = ""
    var spent_time:String = ""
    var joined_friend_id:String = ""
    var panelty:String = ""
    var payment_id:String = ""
    var payment_status:String = ""
}

class CategoryEvent {
    var id:String = ""
    var name:String = ""
    var status:String = ""
}

class eventShedule {
    var allowed_time:String = ""
    var amout:String = ""
    var category_id:String = ""
    var category_name:String = ""
    var date:String = ""
    var event_date:String = ""
    var event_duration:String = ""
    var id:String = ""
    var start_time:String = ""
    var status:String = ""
    var time:String = ""
    var user_id:String = ""
    var name:String = ""
    var type:String = ""
}

class participateFriend {
    var email:String = ""
    var first_name:String = ""
    var image:String = ""
    var joined_status:String = ""
    var last_name:String = ""
    var joined_friend_id:String = ""
    var me:Bool = false
    var panelty:String = ""
    var payment_button:String = ""
    var payment_status:String = ""
    var spent_time:String = ""
}

class ParticipatedEvent {
    var allowed_time:String = ""
    var amout:String = ""
    var category_id:String = ""
    var category_name:String = ""
    var date:String = ""
    var event_date:String = ""
    var event_duration:String = ""
    var id:String = ""
    var start_time:String = ""
    var status:String = ""
    var time:String = ""
    var user_id:String = ""
    var name:String = ""
    var type:String = ""
    var event_id:String = ""
    var created_by_id:String = ""
}

//class pariticipateDetail {
//    var id:String = ""
//    var user_id:String = ""
//    var category_id:String = ""
//    var name:String = ""
//    var event_duration:String = ""
//    var amout:String = ""
//    var allowed_time:String = ""
//    var event_date:String = ""
//    var start_time:String = ""
//    var date:String = ""
//    var time:String = ""
//    var first_name:String = ""
//    var last_name:String = ""
//    var email:String = ""
//    var created_by:String = ""
//    var event_status:String = ""
//    var category_name:String = ""
//}

class participateDetailFriends {
    var email:String = ""
    var first_name:String = ""
    var image:String = ""
    var last_name:String = ""
    var joined_friend_id:String = ""
    var createdById:String = ""
  //  var createdById:String = ""
    var joined_status:String = ""
    var id:String = ""
    var panelty:String = ""
    var payment_button:String = ""
    var payment_status:String = ""
    var spent_time:String = ""
    var me:Bool = false
}

