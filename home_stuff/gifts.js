const FAMILY = require('./sheridan.json')

function assignGifts(toAssign, toBeAssigned, result) {
	if (!toAssign.length) return result

	const memberToAssign = toAssign.shift()
	const filteredAssignList = toBeAssigned.filter(member => !memberToAssign.block.includes(member.name))
	const assignTo = filteredAssignList[randomIndex(filteredAssignList.length)]
	toBeAssigned.splice(toBeAssigned.indexOf(assignTo), 1)
	let blockMe = toAssign.find(member => member.name == assignTo.name)
	if (blockMe) blockMe.block.push(memberToAssign.name)

	result += `${memberToAssign.name} is assigned to ${assignTo.name}\n`
	return assignGifts(toAssign, toBeAssigned, result)
}


function randomIndex(length) {
  return Math.floor(Math.random() * length);
}

console.log(assignGifts([...FAMILY], [...FAMILY], ''))