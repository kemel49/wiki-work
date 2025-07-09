local p = {}

function p.render(frame)
	local args = frame:getParent().args
	local header = args.header or "Medal Tally"
	local class = args.class or ""

	local result = {}
	table.insert(result, string.format('<table class="wikitable %s" style="text-align:center;">', class))
	table.insert(result, string.format('<caption>%s</caption>', header))
	table.insert(result, '<tr><th>Rank</th><th>Team</th><th style="background-color: #FFD700;">Gold</th><th style="background-color: C0C0C0;">Silver</th><th style="background-color: #CD7F32;">Bronze</th><th>Total</th></tr>')

	local medals = {}
	local totalGold, totalSilver, totalBronze = 0, 0, 0

	for i = 1, 8 do
		local team = args['team' .. i]
		local gold = tonumber(args['gold' .. i]) or 0
		local silver = tonumber(args['silver' .. i]) or 0
		local bronze = tonumber(args['bronze' .. i]) or 0
		local total = gold + silver + bronze

		if team then
			table.insert(medals, {rank = i, team = team, gold = gold, silver = silver, bronze = bronze, total = total})
			totalGold = totalGold + gold
			totalSilver = totalSilver + silver
			totalBronze = totalBronze + bronze
		end
	end

	table.sort(medals, function(a, b)
		if a.gold ~= b.gold then return a.gold > b.gold end
		if a.silver ~= b.silver then return a.silver > b.silver end
		return a.bronze > b.bronze
	end)

	for index, entry in ipairs(medals) do
		table.insert(result, string.format('<tr><td>%d</td><td>%s</td><td>%d</td><td>%d</td><td>%d</td><td>%d</td></tr>',
		index, entry.team, entry.gold, entry.silver, entry.bronze, entry.total))
	end

	local totalMedals = totalGold + totalSilver + totalBronze
	table.insert(result, string.format('<tr><th colspan="2">Total</th><td>%d</td><td>%d</td><td>%d</td><td>%d</td></tr>',
	totalGold, totalSilver, totalBronze, totalMedals))
	table.insert(result, '</table>')

	return table.concat(result, "\n")
end

return p
