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
        receivedMessage.removeAttribute('id');
        receivedMessageDiv.removeAttribute('id');
        receivedMessageAvatar.removeAttribute('id');
        // make it scroll to the end of the conversation
        // find the conversation div
        // scroll till the end
        messagesContainer.scrollTop = messagesContainer.scrollHeight;

        // focus on the text_area again after submitting
        document.querySelector("#message_content").focus()
      },
    });

    //////////////////////////////////////
    // Scroll the chat box on page load //
    //////////////////////////////////////
    messagesContainer.scrollTop = messagesContainer.scrollHeight;

    //////////////////////////////////////
    // Press enter to send the message //
    //////////////////////////////////////
    const form = document.querySelector("#new_message");
    form.addEventListener('keypress', (event) => {
      if (event.key === 'Enter') form.submit();
    });
    
  }
}

export { initChatroomCable };
