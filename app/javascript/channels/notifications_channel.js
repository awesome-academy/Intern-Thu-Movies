import consumer from "./consumer"

document.addEventListener("turbolinks:load", () => {
  let admin_id = $("#admin_id").val();
  consumer.subscriptions.create(
    {channel: "NotificationsChannel", admin_id: admin_id},
    {
      connected() {},
      disconnected() {},
      received(data) {
        $("#cotification_count").html(data.count);
        $("#notifications_list").html(data.notify);
      },
    }
  );
})
