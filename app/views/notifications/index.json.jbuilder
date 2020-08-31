json.array! @notifications do |notification|
  json.id notification.id
  # <!-- json.recipient notification.recipient -->
  json.actor notification.actor.first_name
  json.actor notification.actor.last_name
  json.action notification.action
  json.notifiable do
    json.type "a message"
  end
  json.url chatroom_path(notification.notifiable.chatroom, anchor: dom_id(notification.notifiable))
end
