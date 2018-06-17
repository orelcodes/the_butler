require 'telegram/bot'
require 'env_inspector'

EnvInspector.configure do |config|
  config.env_list = ['OREL_CODES_TELEGRAM_BOT_TOKEN']
end

EnvInspector::Inspector.check!

TOKEN = 'OREL_CODES_TELEGRAM_BOT_TOKEN'

Telegram::Bot::Client.run(TOKEN) do |bot|
  bot.listen do |message|
    if message.new_chat_members
      message.new_chat_members.each do |member|
        bot.api.send_message(
          chat_id: message.chat.id,
          reply_to_message_id: message.message_id,
          text: "Добрый день, #{member.first_name} #{member.last_name}. Если не сложно представься и расскажи немного о себе. Кто ты? Откуда? Работаешь или учишься? Что привело тебя к нам?"
        )
      end
    end
  end
end