import consumer from "./consumer";

const initChatroomCable = () => {
  const messagesContainer = document.getElementById('messages');
  if (messagesContainer) {
    const id = messagesContainer.dataset.chatroomId;

    consumer.subscriptions.create({ channel: "ChatroomChannel", id: id }, {
      received(data) {
        console.log(data);
        messagesContainer.insertAdjacentHTML('beforeend', data);
        document.getElementById("message_content").value = ""; // called when data is broadcast in the cable
        const receivedMessage = document.getElementById('sender');
        const receivedMessageDiv = document.getElementById('last-message');
        const receivedMessageAvatar = document.getElementById('last-avatar');
        const senderId = receivedMessage.dataset.userId;
        const userIsReceiver = document.getElementById(`user-${senderId}`);
        if (userIsReceiver) {
          receivedMessageDiv.classList.add("message-text-in");
        } else {
          receivedMessageDiv.classList.add("message-text-out");
          receivedMessageAvatar.remove();
        }
        receivedMessageDiv.removeAttribute('id');
        receivedMessageAvatar.removeAttribute('id');
        // make it scroll to the end of the conversation
        // find the conversation div
        const messagesDiv = document.getElementById('messages');
        // scroll till the end
        messagesDiv.scrollTop = messagesDiv.scrollHeight;
      },
    });
  }
}

export { initChatroomCable };
