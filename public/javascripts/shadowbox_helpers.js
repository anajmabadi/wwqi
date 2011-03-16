/**
 * @author historicus
 */
function openShadowbox(content, player, width, height, title) {
	Shadowbox.open({
		content: content,
		player: player,
		width: width,
		height: height,
		options: { animate: false, enableKeys: false }
	});
}

Shadowbox.init({ enableKeys: false});