

local AirdropedAtBlock = AirdropedAtBlock or {}

AIRDROPPED_QUANTITY = "10000000000000"

Handlers.add('airdrop-tokens', Handlers.utils.hasMatchingTag('Action', 'tSENTI-drop'), function(msg)
    local currentHeight = tonumber(msg['Block-Height'])
    local address
    if not msg.Recipient then
      address = msg.From
    else
      address = msg.Recipient
    end

    if AirdropedAtBlock[address] then
        assert(currentHeight - AirdropedAtBlock[address] > 1, "Please wait for some time before requesting airdrop again!")
    end

    AirdropedAtBlock[address] = currentHeight

    print("sending " .. AIRDROPPED_QUANTITY .. " tokens ")

    ao.send({
      Target = msg.Target,
      Recipient = address,
      Action = 'Transfer',
      Quantity = AIRDROPPED_QUANTITY,
    })

  end)


return AirdropedAtBlock