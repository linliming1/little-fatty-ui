if not WeakAuras.IsCorrectVersion() then return end

if not(GetLocale() == "zhCN") then
  return
end

local L = WeakAuras.L

-- WeakAuras/Options
	L[" and |cFFFF0000mirrored|r"] = "并且|cFFFF0000镜像|r"
	L["-- Do not remove this comment, it is part of this aura: "] = "-- 不要移除此注释，这是此光环的一部分："
	L[" rotated |cFFFF0000%s|r degrees"] = "旋转|cFFFF0000%s|r度"
	L["% of Progress"] = "进度%"
	L["%i auras selected"] = "已选中%i个光环"
	L["%i Matches"] = "%i个符合"
	L["%s - Option #%i has the key %s. Please choose a different option key."] = "%s - 选项#%i已经使用了键%s，请选择一个其他的键。"
	L["%s %s, Lines: %d, Frequency: %0.2f, Length: %d, Thickness: %d"] = "%s %s，行数：%d，频率：%0.2f，长度：%d，粗细：%d"
	L["%s %s, Particles: %d, Frequency: %0.2f, Scale: %0.2f"] = "%s %s，粒子数：%d，频率：%0.2f，缩放：%0.2f"
	L["%s Alpha: %d%%"] = "%s 透明度：%d%%"
	L["%s Color"] = "%s 颜色"
	L["%s Default Alpha, Zoom, Icon Inset, Aspect Ratio"] = "%s 默认透明度，缩放，内嵌，宽高比"
	L["%s Inset: %d%%"] = "%s 内嵌：%d%%"
	L["%s is not a valid SubEvent for COMBAT_LOG_EVENT_UNFILTERED"] = "%s不是COMBAT_LOG_EVENT_UNFILTERED的有效子事件"
	L["%s Keep Aspect Ratio"] = "%s 保持宽高比"
	L["%s Texture"] = "%s 材质"
	L["%s total auras"] = "共%s个光环"
	L["%s Zoom: %d%%"] = "%s 缩放：%d%%"
	L["%s, Border"] = "%s，边框"
	L["%s, Offset: %0.2f;%0.2f"] = "%s，偏移：%0.2f; %0.2f"
	L["%s, offset: %0.2f;%0.2f"] = "%s，偏移：%0.2f; %0.2f"
	L["%s|cFFFF0000custom|r texture with |cFFFF0000%s|r blend mode%s%s"] = "%s|cFFFF0000自定义|r材质，|cFFFF0000%s|r混合模式%s%s"
	L["(Right click to rename)"] = "（右键点击以重命名）"
	L["|c%02x%02x%02x%02xCustom Color|r"] = "|c%02x%02x%02x%02x自定义颜色|r"
	L["|cFFE0E000Note:|r This sets the description only on '%s'"] = "|cFFE0E000注意：|r此操作只会设置'%s'的描述"
	L["|cFFE0E000Note:|r This sets the URL on all selected auras"] = "|cFFE0E000注意：|r此操作会设置所有已选择光环的URL"
	L["|cFFE0E000Note:|r This sets the URL on this group and all its members."] = "|cFFE0E000注意：|r此操作会设置群组与所有子项目的URL"
	L["|cFFFF0000Automatic|r length"] = "|cFFFF0000自动|r长度"
	L["|cFFFF0000default|r texture"] = "|cFFFF0000默认|r材质"
	L["|cFFFF0000desaturated|r "] = "|cFFFF0000褪色|r"
	L["|cFFFF0000Note:|r The unit '%s' is not a trackable unit."] = "|cFFFF0000注意：|r '%s' 不是一个可以追踪的单位。"
	L["|cFFffcc00Anchors:|r Anchored |cFFFF0000%s|r to frame's |cFFFF0000%s|r"] = "|cFFffcc00锚点：|r将|cFFFF0000%s|r对齐至框架的|cFFFF0000%s|r"
	L["|cFFffcc00Anchors:|r Anchored |cFFFF0000%s|r to frame's |cFFFF0000%s|r with offset |cFFFF0000%s/%s|r"] = "|cFFffcc00锚点：|r将|cFFFF0000%s|r对齐至框架的|cFFFF0000%s|r，偏移|cFFFF0000%s/%s|r"
	L["|cFFffcc00Anchors:|r Anchored to frame's |cFFFF0000%s|r"] = "|cFFffcc00锚点：|r对齐至框架的|cFFFF0000%s|r"
	L["|cFFffcc00Anchors:|r Anchored to frame's |cFFFF0000%s|r with offset |cFFFF0000%s/%s|r"] = "|cFFffcc00锚点：|r对齐至框架的|cFFFF0000%s|r，偏移|cFFFF0000%s/%s|r"
	L["|cFFffcc00Extra Options:|r"] = "|cFFffcc00额外选项：|r"
	L["|cFFffcc00Extra:|r %s and %s %s"] = "|cFFffcc00额外：|r%s 并且 %s %s"
	L["|cFFffcc00Font Flags:|r |cFFFF0000%s|r and shadow |c%sColor|r with offset |cFFFF0000%s/%s|r%s%s"] = "|cFFffcc00文字样式：|r|cFFFF0000%s|r，阴影|c%s颜色|r、偏移量|cFFFF0000%s/%s|r%s%s"
	L["|cFFffcc00Font Flags:|r |cFFFF0000%s|r and shadow |c%sColor|r with offset |cFFFF0000%s/%s|r%s%s%s"] = "|cFFffcc00文字样式：|r|cFFFF0000%s|r，阴影|c%s颜色|r、偏移量|cFFFF0000%s/%s|r%s%s%s"
	L["|cFFffcc00Format Options|r"] = "|cFFffcc00格式选项|r"
	L["1 Match"] = "1个符合"
	L["A 20x20 pixels icon"] = "20x20像素图标"
	L["A 32x32 pixels icon"] = "32x32像素图标"
	L["A 40x40 pixels icon"] = "40x40像素图标"
	L["A 48x48 pixels icon"] = "48x48像素图标"
	L["A 64x64 pixels icon"] = "64x64像素图标"
	L["A group that dynamically controls the positioning of its children"] = "动态控制子项目位置的群组"
	L["A Unit ID (e.g., party1)."] = "单位 ID（如 party1）。"
	L["Actions"] = "动作"
	L["Add"] = "添加"
	L["Add %s"] = "添加 %s"
	L["Add a new display"] = "添加一个新的图示"
	L["Add Condition"] = "添加条件"
	L["Add Entry"] = "添加条目"
	L["Add Extra Elements"] = "添加额外元素"
	L["Add Option"] = "添加选项"
	L["Add Overlay"] = "添加覆盖层"
	L["Add Property Change"] = "添加属性修改"
	L["Add Raid Mark Information"] = "添加团队标记信息"
	L["Add Role Information"] = "添加职责信息"
	L["Add Snippet"] = "添加片段"
	L["Add Sub Option"] = "添加子选项"
	L["Add to group %s"] = "添加到组％s"
	L["Add to new Dynamic Group"] = "添加到新的动态群组"
	L["Add to new Group"] = "添加到新的群组"
	L["Add Trigger"] = "添加触发器"
	L["Additional Events"] = "额外事件"
	L["Addon"] = "插件"
	L["Addons"] = "插件"
	L["Advanced"] = "高级"
	L["Align"] = "对齐"
	L["Alignment"] = "对齐"
	L["All of"] = "全部"
	L["Allow Full Rotation"] = "允许完全旋转"
	L["Alpha"] = "透明度"
	L["Anchor"] = "锚点"
	L["Anchor Point"] = "锚点指向"
	L["Anchored To"] = "对齐到"
	L["And "] = "和"
	L["and"] = "和"
	L["and aligned left"] = "并且左对齐"
	L["and aligned right"] = "并且右对齐"
	L["and rotated left"] = "并且向左旋转"
	L["and rotated right"] = "并且向右旋转"
	L["and Trigger %s"] = "和触发器 %s"
	L["and with width |cFFFF0000%s|r and %s"] = "并且宽度|cFFFF0000%s|r 并且%s"
	L["Angle"] = "角度"
	L["Animate"] = "动画"
	L["Animated Expand and Collapse"] = "展开折叠动画"
	L["Animates progress changes"] = "进度变化动画"
	L["Animation End"] = "动画结束"
	L["Animation Mode"] = "动画模式"
	L["Animation relative duration description"] = [=[动画的相对持续时间，表示为 分数(1/2)，百分比(50％)，或数字(0.5)。
|cFFFF0000注意：|r 如果没有进度(没有时间事件的触发器,没有持续时间的光环,或其他)，动画将不会播放。
|cFF4444FF举例：|r
如果动画的持续时间设定为 |cFF00CC0010%|r，然后触发的增益时间为20秒，入场动画会播放2秒。
如果动画的持续时间设定为 |cFF00CC0010%|r，然后触发的增益没有持续时间，将不会播放开始动画.]=]
	L["Animation Sequence"] = "动画序列"
	L["Animation Start"] = "动画开始"
	L["Animations"] = "动画"
	L["Any of"] = "任意的"
	L["Apply Template"] = "应用模板"
	L["Arcane Orb"] = "奥术宝珠"
	L["At a position a bit left of Left HUD position."] = "在左侧HUD偏左一点的位置。"
	L["At a position a bit left of Right HUD position"] = "在右侧HUD偏左一点的位置。"
	L["At the same position as Blizzard's spell alert"] = "与暴雪的法术警报在同一位置"
	L[ [=[Aura is
Off Screen]=] ] = "光环在屏幕外"
	L["Aura Name"] = "光环名称"
	L["Aura Name Pattern"] = "光环名称规则匹配"
	L["Aura Type"] = "光环类型"
	L["Aura(s)"] = "光环"
	L["Author Options"] = "作者选项"
	L["Auto-Clone (Show All Matches)"] = "自动克隆（显示所有符合项）"
	L["Auto-cloning enabled"] = "自动克隆已启用"
	L["Automatic"] = "自动"
	L["Automatic length"] = "自动长度"
	L["Available Voices are system specific"] = "可用的声音由系统决定"
	L["Backdrop Color"] = "背景颜色"
	L["Backdrop in Front"] = "背景在前"
	L["Backdrop Style"] = "背景图案类型 "
	L["Background"] = "背景"
	L["Background Color"] = "背景色"
	L["Background Inner"] = "背景内部"
	L["Background Offset"] = "背景偏移"
	L["Background Texture"] = "背景材质"
	L["Bar Alpha"] = "进度条透明度"
	L["Bar Color"] = "进度条颜色"
	L["Bar Color Settings"] = "进度条颜色设置"
	L["Bar Texture"] = "进度条材质"
	L["Big Icon"] = "大图标"
	L["Blend Mode"] = "混合模式"
	L["Blue Rune"] = "蓝色符文"
	L["Blue Sparkle Orb"] = "蓝色闪光宝珠"
	L["Border"] = "边框"
	L["Border %s"] = "边框 %s"
	L["Border Anchor"] = "边框锚点"
	L["Border Color"] = "边框颜色"
	L["Border in Front"] = "边框在前"
	L["Border Inset"] = "边框内嵌"
	L["Border Offset"] = "边框偏移"
	L["Border Settings"] = "边框设置"
	L["Border Size"] = "边框大小 "
	L["Border Style"] = "边框风格"
	L["Bottom"] = "底部"
	L["Bottom Left"] = "左下"
	L["Bottom Right"] = "右下"
	L["Bracket Matching"] = "括号自动匹配"
	L["Browse Wago, the largest collection of auras."] = "浏览Wago，最大的光环集合网站。"
	L["Can be a Name or a Unit ID (e.g. party1). A name only works on friendly players in your group."] = "可以是名字或单位 ID（例如 party1），只有在群组中的友方玩家名字是有效的。"
	L["Can be a UID (e.g., party1)."] = "可以是单位 ID（例如：party1）。"
	L["Cancel"] = "取消"
	L["Cast by Player Character"] = "玩家角色施放"
	L["Cast by Players"] = "玩家施放"
	L["Center"] = "中间"
	L["Chat Message"] = "聊天信息"
	L["Chat with WeakAuras experts on our Discord server."] = "在我们的Discord服务器上与WeakAuras专家聊天。"
	L["Check On..."] = "检查..."
	L["Check out our wiki for a large collection of examples and snippets."] = "查看我们的Wiki，获取大量的例子与代码片段。"
	L["Children:"] = "子项目："
	L["Choose"] = "选择"
	L["Class"] = "职业"
	L["Clip Overlays"] = "裁剪覆盖层"
	L["Clipped by Progress"] = "被进度条遮挡"
	L["Close"] = "关闭"
	L["Collapse"] = "折叠"
	L["Collapse all loaded displays"] = "折叠所有载入的图示"
	L["Collapse all non-loaded displays"] = "折叠所有未载入的图示"
	L["Collapse all pending Import"] = "折叠所有待定的导入"
	L["Collapsible Group"] = "可折叠的组"
	L["color"] = "颜色"
	L["Color"] = "颜色"
	L["Column Height"] = "行高度"
	L["Column Space"] = "行空间"
	L["Columns"] = "列"
	L["Combinations"] = "组合"
	L["Combine Matches Per Unit"] = "组合每个单位的匹配"
	L["Common Text"] = "一般文本"
	L["Compare against the number of units affected."] = "比较受影响的单位数量"
	L["Compatibility Options"] = "兼容性选项"
	L["Compress"] = "压缩"
	L["Condition %i"] = "条件 %i"
	L["Conditions"] = "条件"
	L["Configure what options appear on this panel."] = "配置哪些选项出现在此面板中"
	L["Constant Factor"] = "常数因子"
	L["Control-click to select multiple displays"] = "按住 Control 并点击来选择多个光环"
	L["Controls the positioning and configuration of multiple displays at the same time"] = "同时控制多个图示的位置和设定"
	L["Convert to New Aura Trigger"] = "转换为新的光环触发器"
	L["Convert to..."] = "转换为..."
	L["Cooldown Edge"] = "冷却边缘"
	L["Cooldown Settings"] = "冷却设置"
	L["Cooldown Swipe"] = "冷却旋转动画"
	L["Copy"] = "拷贝"
	L["Copy settings..."] = "拷贝设置"
	L["Copy to all auras"] = "拷贝至所有的光环"
	L["Could not parse '%s'. Expected a table."] = "无法解析'%s'，需要 table。"
	L["Count"] = "计数 "
	L["Counts the number of matches over all units."] = "计算所有单位上匹配的数量"
	L["Creating buttons: "] = "创建按钮:"
	L["Creating options: "] = "创建配置:"
	L["Crop X"] = "裁剪X"
	L["Crop Y"] = "裁剪Y"
	L["Custom"] = "自定义"
	L["Custom Anchor"] = "自定义锚点"
	L["Custom Background"] = "自定义背景"
	L["Custom Check"] = "自定义检查"
	L["Custom Code"] = "自定义代码"
	L["Custom Color"] = "自定义颜色"
	L["Custom Configuration"] = "自定义设置"
	L["Custom Foreground"] = "自定义前景"
	L["Custom Frames"] = "自定义框架"
	L["Custom Function"] = "自定义函数"
	L["Custom Grow"] = "自定义生长"
	L["Custom Options"] = "自定义选项"
	L["Custom Sort"] = "自定义排序"
	L["Custom Trigger"] = "自定义生效触发器"
	L["Custom trigger event tooltip"] = [=[选择用于检查自订触发的事件。
如果有多个事件,可以用逗号或空白分隔。

|cFF4444FF例：|r
UNIT_POWER, UNIT_AURA PLAYER_TARGET_CHANGED]=]
	L["Custom trigger status tooltip"] = [=[选择用于检查自订触发的事件。
因为这一个是状态触发器, 指定的事件 可以被 WeakAuras 调用, 而不需指定参数.
如果有多个事件,可以用逗号或空白分隔。

|cFF4444FF例：|r
UNIT_POWER, UNIT_AURA PLAYER_TARGET_CHANGED]=]
	L["Custom Untrigger"] = "自定义失效触发器"
	L["Custom Variables"] = "自定义变量"
	L["Debuff Type"] = "减益类型"
	L["Default"] = "默认"
	L["Default Color"] = "默认颜色"
	L["Delete"] = "删除"
	L["Delete all"] = "删除所有"
	L["Delete children and group"] = "删除子项目和组"
	L["Delete Entry"] = "删除条目"
	L["Desaturate"] = "褪色"
	L["Description"] = "描述"
	L["Description Text"] = "描述文本"
	L["Determines how many entries can be in the table."] = "决定表格中可以有多少条目"
	L["Differences"] = "差异"
	L["Disabled"] = "禁用"
	L["Disallow Entry Reordering"] = "不允许重新排列条目"
	L["Discrete Rotation"] = "离散旋转"
	L["Display"] = "图示"
	L["Display Name"] = "显示的名字"
	L["Display Text"] = "图示文字"
	L["Displays a text, works best in combination with other displays"] = "显示一条文本，最好与其他显示效果结合运用"
	L["Distribute Horizontally"] = "横向分布"
	L["Distribute Vertically"] = "纵向分布"
	L["Do not group this display"] = "不要将此图示编组"
	L["Do you want to ignore all future updates for this aura"] = "你想忽略此光环未来的所有更新吗"
	L["Documentation"] = "文档"
	L["Done"] = "完成"
	L["Drag to move"] = "拖拽来移动"
	L["Duplicate"] = "复制"
	L["Duplicate All"] = "复制所有"
	L["Duration (s)"] = "持续时间"
	L["Duration Info"] = "持续时间讯息"
	L["Dynamic Duration"] = "动态时长"
	L["Dynamic Group"] = "动态群组"
	L["Dynamic Group Settings"] = "动态群组设置"
	L["Dynamic Information"] = "动态信息"
	L["Dynamic information from first active trigger"] = "排列最前的活跃的触发器的动态信息"
	L["Dynamic information from Trigger %i"] = "触发器%i的动态信息"
	L["Dynamic text tooltip"] = [=[这里有几个特别的编码允许文字动态显示：

|cFFFF0000%p|r - 进度 - 剩余持续时间或非时间值
|cFFFF0000%t|r - 总共 - 总持续时间或最大的非时间值
|cFFFF0000%n|r - 名称 - 图示名称(通常是光环名称)或是没有动态名称图示的编号
|cFFFF0000%i|r - 图标 - 图示关连的显标
|cFFFF0000%s|r - 堆叠 - 光环堆叠数量(通常)
|cFFFF0000%c|r - 自定义 - 允许你自定义一个Lua函数并返回一个用于显示的字符串]=]
	L["Ease Strength"] = "缓动强度"
	L["Ease type"] = "缓动类型"
	L["Edge"] = "边缘"
	L["eliding"] = "省略"
	L["Else If"] = "否则如果"
	L["Else If Trigger %s"] = "否则如果触发器%s"
	L["Enabled"] = "启用"
	L["End Angle"] = "结束角度"
	L["End of %s"] = "%s 的结尾"
	L["Enter a Spell ID"] = "输入一个法术 ID"
	L["Enter an aura name, partial aura name, or spell id"] = "输入全部或部分光环名称，或者法术 ID"
	L["Enter an Aura Name, partial Aura Name, or Spell ID. A Spell ID will match any spells with the same name."] = "输入全部或部分光环名称，或者法术 ID。如果输入法术 ID，则会匹配所有具有相同名称的法术。"
	L["Enter Author Mode"] = "进入作者模式"
	L["Enter in a value for the tick's placement."] = "输入进度指示放置位置的值"
	L["Enter User Mode"] = "进入用户模式"
	L["Enter user mode."] = "进入到使用者的模式。"
	L["Entry %i"] = "条目 %i"
	L["Entry limit"] = "条目限制"
	L["Entry Name Source"] = "条目名称来源"
	L["Event Type"] = "事件类型"
	L["Event(s)"] = "事件（复数）"
	L["Everything"] = "全部"
	L["Exact Spell ID(s)"] = "精确法术 ID"
	L["Exact Spell Match"] = "严格法术匹配"
	L["Expand"] = "展开"
	L["Expand all loaded displays"] = "展开所有载入的图示"
	L["Expand all non-loaded displays"] = "展开所有未载入的图示"
	L["Expand all pending Import"] = "展开所有待定的导入"
	L["Expansion is disabled because this group has no children"] = "由于此组没有子项目，所以无法进行扩展"
	L["Export to Lua table..."] = "导出为 Lua 表格..."
	L["Export to string..."] = "导出为字符串"
	L["External"] = "外部"
	L["Fade"] = "淡化"
	L["Fade In"] = "渐入"
	L["Fade Out"] = "渐出"
	L["Fallback"] = "后备"
	L["Fallback Icon"] = "后备图标"
	L["False"] = "假"
	L["Fetch Affected/Unaffected Names"] = "获取受影响的/未受影响的名称"
	L["Filter by Arena Spec"] = "根据竞技场专精过滤"
	L["Filter by Class"] = "根据职业过滤"
	L["Filter by Group Role"] = "根据团队职责过滤"
	L["Filter by Nameplate Type"] = "根据姓名版类型过滤"
	L["Filter by Raid Role"] = "根据团队职责过滤"
	L[ [=[Filter formats: 'Name', 'Name-Realm', '-Realm'.

Supports multiple entries, separated by commas
]=] ] = "过滤格式：'名称'，'名称-服务器'，'-服务器'。支持多个条目，由英文逗号分隔。"
	L["Find Auras"] = "寻找光环"
	L["Finish"] = "结束"
	L["Fire Orb"] = "火焰宝珠"
	L["Font"] = "字体"
	L["Font Size"] = "字体大小"
	L["Foreground"] = "前景"
	L["Foreground Color"] = "前景色"
	L["Foreground Texture"] = "前景材质"
	L["Format"] = "格式"
	L["Format for %s"] = "%s 的格式"
	L["Found a Bug?"] = "发现了故障？"
	L["Frame"] = "框体"
	L["Frame Count"] = "帧数"
	L["Frame Rate"] = "帧率"
	L["Frame Selector"] = "选择框体"
	L["Frame Strata"] = "框架层级"
	L["Frequency"] = "频率"
	L["From Template"] = "从模板"
	L["Full Circle"] = "完整圆形"
	L["Get Help"] = "寻求帮助"
	L["Global Conditions"] = "全局条件"
	L["Glow %s"] = "发光 %s"
	L["Glow Action"] = "发光动作"
	L["Glow Anchor"] = "发光锚点"
	L["Glow Color"] = "发光颜色"
	L["Glow External Element"] = "发光外部元素"
	L["Glow Frame Type"] = "发光框体类型"
	L["Glow Type"] = "发光类型"
	L["Green Rune"] = "绿色符文"
	L["Grid direction"] = "表格方向"
	L["Group"] = "组"
	L["Group (verb)"] = "群组（动态）"
	L["Group aura count description"] = [=[所输入的队伍或团队成员的数量必须给定一个或多个光环作为显示触发的条件。
如果输入的数字是一个整数（如5），受影响的团队成员数量将与输入的数字相同。
如果输入的数字是一个小数（如0.5），分数（例如1/2），或百分比（例如50%%），那么多比例的队伍或团队成员的必须受到影响。
|cFF4444FF举例：|r
|cFF00CC00大于 0|r  会在任意一人受影响时触发
|cFF00CC00等于 100%%|r 会在所有人受影响时触发
|cFF00CC00不等于 2|r 会在2人受影响之外时触发
|cFF00CC00小于等于 0.8|r 会在小于80%%的人受影响时触发
|cFF00CC00大于 1/2|r 会在超过一半以上的人受影响时触发
|cFF00CC00大于等于 0|r 总是触发]=]
	L["Group by Frame"] = "根据框体分组"
	L["Group Description"] = "组描述"
	L["Group Icon"] = "组图标"
	L["Group key"] = "组键值"
	L["Group Member Count"] = "群组成员数"
	L["Group Options"] = "群组选项"
	L["Group Role"] = "团队职责"
	L["Group Scale"] = "组缩放"
	L["Group Settings"] = "群组设置"
	L["Group Type"] = "组类别"
	L["Grow"] = "生长"
	L["Hawk"] = "鹰"
	L["Height"] = "高度"
	L["Help"] = "帮助"
	L["Hide"] = "隐藏"
	L["Hide Cooldown Text"] = "隐藏冷却文本"
	L["Hide Glows applied by this aura"] = "隐藏由此光环应用的发光"
	L["Hide on"] = "隐藏于"
	L["Hide this group's children"] = "隐藏此组的子项目"
	L["Hide When Not In Group"] = "不在队伍时隐藏"
	L["Horizontal Align"] = "水平对齐"
	L["Horizontal Bar"] = "水平条"
	L["Hostility"] = "敌对"
	L["Huge Icon"] = "巨型图标"
	L["Hybrid Position"] = "混合定位"
	L["Hybrid Sort Mode"] = "混合排序模式"
	L["Icon"] = "图标"
	L["Icon Info"] = "图标信息"
	L["Icon Inset"] = "图标内嵌"
	L["Icon Position"] = "图标位置"
	L["Icon Settings"] = "图标设置"
	L["Icon Source"] = "图标来源"
	L["If"] = "如果"
	L["If checked, then the user will see a multi line edit box. This is useful for inputting large amounts of text."] = "勾选后，用户可以看见一个多行的输入框，在输入大量文本时很有用。"
	L["If checked, then this option group can be temporarily collapsed by the user."] = "勾选后，选项组可以临时被用户折叠"
	L["If checked, then this option group will start collapsed."] = "勾选后，选项组将会在打开时折叠"
	L["If checked, then this separator will include text. Otherwise, it will be just a horizontal line."] = "勾选后，则此分隔符将会包含文本，否则就只是一条横线。"
	L["If checked, then this separator will not merge with other separators when selecting multiple auras."] = "勾选后，此分隔符不会在选中多个光环时与其他分隔符合并。"
	L["If checked, then this space will span across multiple lines."] = "勾选后，此空白区域将横跨多行。"
	L["If Trigger %s"] = "如果触发器 %s"
	L["If unchecked, then a default color will be used (usually yellow)"] = "如果不勾选，则使用默认颜色（通常是黄色）"
	L["If unchecked, then this space will fill the entire line it is on in User Mode."] = "如果不勾选，则在用户模式下此空白区域将填充一整行。"
	L["Ignore Dead"] = "忽略已死亡"
	L["Ignore Disconnected"] = "忽略已离线"
	L["Ignore Lua Errors on OPTIONS event"] = "忽略OPTIONS事件产生的Lua错误"
	L["Ignore out of checking range"] = "忽略超出检查范围"
	L["Ignore Self"] = "忽略自身"
	L["Ignore self"] = "忽略自身"
	L["Ignore updates"] = "忽略更新"
	L["Ignored"] = "被忽略"
	L["Ignored Aura Name"] = "忽略光环名称"
	L["Ignored Exact Spell ID(s)"] = "忽略精确法术 ID"
	L["Ignored Name(s)"] = "忽略名称"
	L["Ignored Spell ID"] = "忽略法术 ID"
	L["Import"] = "导入"
	L["Import a display from an encoded string"] = "从字串导入一个图示"
	L["Include Pets"] = "包括宠物"
	L["Indent Size"] = "缩进"
	L["Information"] = "信息"
	L["Inner"] = "内部"
	L["Invalid Item Name/ID/Link"] = "无效的物品名称/ID/链接"
	L["Invalid Spell ID"] = "无效的法术 ID"
	L["Invalid Spell Name/ID/Link"] = "无效的法术名称/ID/链接"
	L["Invalid type for '%s'. Expected 'bool', 'number', 'select', 'string', 'timer' or 'elapsedTimer'."] = "'%s'的类型无效，需要'bool'、'number'、'select'、'string'、'timer'或'elapsedTimer'。"
	L["Invalid type for property '%s' in '%s'. Expected '%s'"] = "'%2$s'的属性'%1$s'类型非法，需要'%3$s'"
	L["Inverse"] = "反向"
	L["Inverse Slant"] = "反向倾斜"
	L["Is Boss Debuff"] = "首领施放的减益效果"
	L["Is Stealable"] = "可偷取"
	L["Justify"] = "对齐"
	L["Keep Aspect Ratio"] = "保持比例不变"
	L["Keep your Wago imports up to date with the Companion App."] = "利用Companion应用程序保持你的Wago导入最新。"
	L["Large Input"] = "大输入框"
	L["Leaf"] = "叶子"
	L["Left"] = "左方"
	L["Left 2 HUD position"] = "左侧第二 HUD 位置"
	L["Left HUD position"] = "左侧 HUD 位置"
	L["Length"] = "长度"
	L["Length of |cFFFF0000%s|r"] = "长度|cFFFF0000%s|r"
	L["Limit"] = "限制"
	L["Lines & Particles"] = "线条和粒子"
	L["Linked aura: "] = "关联光环："
	L["Load"] = "载入"
	L["Loaded"] = "已载入"
	L["Lock Positions"] = "锁定位置"
	L["Loop"] = "循环"
	L["Low Mana"] = "低法力值"
	L["Magnetically Align"] = "磁力对齐"
	L["Main"] = "主要的"
	L["Manage displays defined by Addons"] = "由插件管理已定义的图示"
	L["Match Count"] = "计数匹配"
	L["Matches the height setting of a horizontal bar or width for a vertical bar."] = "符合水平进度条的高度设置，或者垂直进度条的宽度设置。"
	L["Max"] = "最大"
	L["Max Length"] = "最大长度"
	L["Medium Icon"] = "中等图标"
	L["Message"] = "信息"
	L["Message Prefix"] = "信息前缀"
	L["Message Suffix"] = "信息后缀"
	L["Message Type"] = "信息类型"
	L["Min"] = "最小"
	L["Mirror"] = "镜像"
	L["Model"] = "模型"
	L["Model %s"] = "模型 %s"
	L["Model Settings"] = "模型设置"
	L["Move Above Group"] = "移动上方的组"
	L["Move Below Group"] = "移动下方的组"
	L["Move Down"] = "向下移"
	L["Move Entry Down"] = "将条目下移"
	L["Move Entry Up"] = "将条目上移"
	L["Move Into Above Group"] = "移动到上方的组"
	L["Move Into Below Group"] = "移动到下方的组"
	L["Move this display down in its group's order"] = "在组内将此显示内容下移"
	L["Move this display up in its group's order"] = "在组内将此显示内容上移"
	L["Move Up"] = "向上移"
	L["Multiple Displays"] = "多个图示"
	L["Multiselect ignored tooltip"] = [=[|cFFFF0000忽略|r - |cFF777777单个|r - |cFF777777多个|r
当图示应该载入时这项设定不应该使用]=]
	L["Multiselect multiple tooltip"] = [=[|cFFFF0000忽略|r - |cFF777777单个|r - |cFF777777多个|r
任何相匹配的值的值可以提取]=]
	L["Multiselect single tooltip"] = [=[|cFFFF0000忽略|r - |cFF777777单个|r - |cFF777777多个|r
只有一个单一的匹配值可以提取]=]
	L["Name Info"] = "名称讯息"
	L["Name Pattern Match"] = "名称规则匹配"
	L["Name(s)"] = "名称"
	L["Name:"] = "名称："
	L["Nameplate"] = "姓名版"
	L["Nameplates"] = "姓名板"
	L["Negator"] = "不"
	L["New Aura"] = "新建"
	L["New Value"] = "新值"
	L["No Children"] = "没有子项目"
	L["None"] = "无"
	L["Not a table"] = "不是 table"
	L["Not all children have the same value for this option"] = "并非所有子项目的此选项的值都一致"
	L["Not Loaded"] = "未载入"
	L["Note: Automated Messages to SAY and YELL are blocked outside of Instances."] = "注意：无法在副本外自动发送“说”与“大喊”信息。"
	L["Note: The legacy buff trigger is now permanently disabled. It will be removed in the near future."] = "注意：传统光环触发器现已被永久禁用。它将会在短期内被移除。"
	L["Number of Entries"] = "条目数"
	L["Offer a guided way to create auras for your character"] = "提供为角色创建光环的指导"
	L["Offset by |cFFFF0000%s|r/|cFFFF0000%s|r"] = "偏移|cFFFF0000%s|r/|cFFFF0000%s|r"
	L["Offset by 1px"] = "偏移1px"
	L["Okay"] = "好"
	L["On Hide"] = "图示隐藏时"
	L["On Init"] = "初始化时"
	L["On Show"] = "图示显示时"
	L["Only Match auras cast by a player (not an npc)"] = "只匹配由玩家（而不是NPC）施放的光环"
	L["Only match auras cast by people other than the player"] = "只匹配其它玩家施放的光环"
	L["Only match auras cast by people other than the player or his pet"] = "只匹配由不是玩家和玩家宠物施放的光环"
	L["Only match auras cast by the player"] = "只匹配玩家自己施放的光环"
	L["Only match auras cast by the player or his pet"] = "只匹配由玩家和玩家宠物施放的光环"
	L["Operator"] = "运算符"
	L["Option %i"] = "选项 %i"
	L["Option key"] = "选项键值"
	L["Option Type"] = "选项类型"
	L["Options will open after combat ends."] = "选项面板将在战斗结束后打开"
	L["or"] = "或"
	L["or Trigger %s"] = "或触发器 %s"
	L["Orange Rune"] = "橙色符文"
	L["Orientation"] = "方向"
	L["Outer"] = "外部"
	L["Outline"] = "轮廓"
	L["Overflow"] = "溢出"
	L["Overlay %s Info"] = "覆盖层 %s 信息"
	L["Overlays"] = "覆盖层"
	L["Own Only"] = "只来源于自己"
	L["Paste Action Settings"] = "粘贴动作设置"
	L["Paste Animations Settings"] = "粘贴动画设置"
	L["Paste Author Options Settings"] = "粘贴作者选项设置"
	L["Paste Condition Settings"] = "粘贴条件设置"
	L["Paste Custom Configuration"] = "粘贴自定义设置"
	L["Paste Display Settings"] = "粘贴显示设置"
	L["Paste Group Settings"] = "粘贴团队设置"
	L["Paste Load Settings"] = "粘贴加载设置"
	L["Paste Settings"] = "粘贴设置"
	L["Paste text below"] = "在下方粘贴文本"
	L["Paste Trigger Settings"] = "粘贴触发器设置"
	L["Places a tick on the bar"] = "在进度条上放置进度指示"
	L["Play Sound"] = "播放声音"
	L["Portrait Zoom"] = "肖像缩放"
	L["Position Settings"] = "位置设置"
	L["Preferred Match"] = "匹配偏好"
	L["Premade Snippets"] = "预设片段"
	L["Preset"] = "预设"
	L["Press Ctrl+C to copy"] = "按 Ctrl+C 复制"
	L["Press Ctrl+C to copy the URL"] = "按 Ctrl+C 复制 URL"
	L["Prevent Merging"] = "阻止合并"
	L["Processed %i chars"] = "已处理%i个字符"
	L["Progress Bar"] = "进度条"
	L["Progress Bar Settings"] = "进度条设置"
	L["Progress Texture"] = "进度条材质"
	L["Progress Texture Settings"] = "进度条材质设置"
	L["Purple Rune"] = "紫色符文"
	L["Put this display in a group"] = "将此显示内容放到组中"
	L["Radius"] = "半径"
	L["Raid Role"] = "团队职责"
	L["Ready for Install"] = "准备安装"
	L["Ready for Update"] = "准备更新"
	L["Re-center X"] = "到中心 X 偏移"
	L["Re-center Y"] = "到中心 Y 偏移"
	L["Regions of type \"%s\" are not supported."] = "%s 区域类型不被支持。"
	L["Remaining Time"] = "剩余时间"
	L["Remove"] = "移除"
	L["Remove this display from its group"] = "从所在组中移除此图示"
	L["Remove this property"] = "移除此属性"
	L["Rename"] = "重命名"
	L["Repeat After"] = "每当此条件发生后重复"
	L["Repeat every"] = "每当此条件满足时重复"
	L["Report bugs on our issue tracker."] = "在我们的问题追踪器里回报故障。"
	L["Require unit from trigger"] = "需要在触发器中指定单位"
	L["Required for Activation"] = "激活需要的条件"
	L["Reset all options to their default values."] = "重置所有选项为默认值"
	L["Reset Entry"] = "重置条目"
	L["Reset to Defaults"] = "重置为默认"
	L["Right"] = "右方"
	L["Right 2 HUD position"] = "右侧第二 HUD 位置"
	L["Right HUD position"] = "右侧 HUD 位置"
	L["Right-click for more options"] = "右键点击获得更多选项"
	L["Rotate"] = "旋转"
	L["Rotate In"] = "旋转进入"
	L["Rotate Out"] = "旋转退出"
	L["Rotate Text"] = "旋转文字"
	L["Rotation"] = "旋转"
	L["Rotation Mode"] = "旋转模式"
	L["Row Space"] = "列空间"
	L["Row Width"] = "列宽度"
	L["Rows"] = "行"
	L["Same"] = "相同"
	L["Scale"] = "缩放"
	L["Search"] = "搜索"
	L["Select the auras you always want to be listed first"] = "选择优先列出的光环"
	L["Send To"] = "发送给"
	L["Separator Text"] = "分隔符文本"
	L["Separator text"] = "分隔符文本"
	L["Set Parent to Anchor"] = "将父框架置于锚点"
	L["Set Thumbnail Icon"] = "设置缩略图标"
	L["Sets the anchored frame as the aura's parent, causing the aura to inherit attributes such as visibility and scale."] = "将锚点框体设置为光环的父框体，使得光环继承锚点框体的一些属性（例如：可见性和缩放）"
	L["Settings"] = "设置"
	L["Shadow Color"] = "阴影颜色"
	L["Shadow X Offset"] = "阴影 X 轴偏移"
	L["Shadow Y Offset"] = "阴影 Y 轴偏移"
	L["Shift-click to create chat link"] = "按住 Shift 点击来生成聊天链接"
	L["Show all matches (Auto-clone)"] = "列出所有符合的(自动复制)"
	L["Show Border"] = "显示边框"
	L["Show Cooldown"] = "显示冷却"
	L["Show Glow"] = "显示发光效果"
	L["Show Icon"] = "显示图标"
	L["Show If Unit Does Not Exist"] = "当单位不存在时显示"
	L["Show If Unit Is Invalid"] = "当单位无效时显示"
	L["Show Matches for"] = "为下列项显示匹配项"
	L["Show Matches for Units"] = "为单位显示匹配项"
	L["Show Model"] = "显示模型"
	L["Show model of unit "] = "显示该单位的模型"
	L["Show On"] = "显示于"
	L["Show Spark"] = "显示闪光效果"
	L["Show Text"] = "显示文本"
	L["Show this group's children"] = "显示此组的子项目"
	L["Show Tick"] = "显示进度指示"
	L["Shows a 3D model from the game files"] = "显示游戏文件中的3D模形"
	L["Shows a border"] = "显示一个边框"
	L["Shows a custom texture"] = "显示自定义材质"
	L["Shows a glow"] = "显示发光效果"
	L["Shows a model"] = "以模型显示"
	L["Shows a progress bar with name, timer, and icon"] = "显示一个有名称，时间，图标的进度条"
	L["Shows a spell icon with an optional cooldown overlay"] = "显示一个法术图标，并有可选的冷却时间显示"
	L["Shows a stop motion texture"] = "显示定格动画材质"
	L["Shows a texture that changes based on duration"] = "显示一个随持续时间而变的材质"
	L["Shows one or more lines of text, which can include dynamic information such as progress or stacks"] = "显示一行或多行文字, 它们包换动态信息, 如进度和叠加层数"
	L["Simple"] = "简单"
	L["Size"] = "大小"
	L["Slant Amount"] = "倾斜程度"
	L["Slant Mode"] = "倾斜模式"
	L["Slanted"] = "倾斜"
	L["Slide"] = "滑动"
	L["Slide In"] = "滑动"
	L["Slide Out"] = "滑出"
	L["Slider Step Size"] = "滑动条步进尺寸"
	L["Small Icon"] = "小图标"
	L["Smooth Progress"] = "过程平滑"
	L["Snippets"] = "片段"
	L["Soft Max"] = "软上限"
	L["Soft Min"] = "软下限"
	L["Sort"] = "排序"
	L["Sound"] = "声音"
	L["Sound Channel"] = "声音频道"
	L["Sound File Path"] = "声音文件路径"
	L["Sound Kit ID"] = "音效 ID"
	L["Source"] = "来源"
	L["Space"] = "间隙"
	L["Space Horizontally"] = "横向间隙"
	L["Space Vertically"] = "纵向间隙"
	L["Spark"] = "闪光"
	L["Spark Settings"] = "闪光设置"
	L["Spark Texture"] = "闪光材质"
	L["Specialization"] = "专精"
	L["Specific Unit"] = "指定单位"
	L["Spell ID"] = "法术ID"
	L["Stack Count"] = "层数"
	L["Stack Info"] = "层数信息"
	L["Stagger"] = "交错"
	L["Star"] = "星星"
	L["Start"] = "开始"
	L["Start Angle"] = "起始角度"
	L["Start Collapsed"] = "打开时折叠"
	L["Start of %s"] = "%s 的开始"
	L["Stealable"] = "可偷取"
	L["Step Size"] = "步进尺寸"
	L["Stop Motion"] = "定格动画"
	L["Stop Motion Settings"] = "定格动画设置"
	L["Stop Sound"] = "停止播放声音"
	L["Sub Elements"] = "子元素"
	L["Sub Option %i"] = "子选项 %i"
	L["Temporary Group"] = "模板群组"
	L["Text"] = "文字"
	L["Text %s"] = "文本 %s"
	L["Text Color"] = "文字颜色"
	L["Text Settings"] = "文本设置"
	L["Texture"] = "材质"
	L["Texture Info"] = "材质信息"
	L["Texture Settings"] = "材质设置"
	L["Texture Wrap"] = "材质折叠"
	L["The duration of the animation in seconds."] = "动画持续秒数"
	L["The duration of the animation in seconds. The finish animation does not start playing until after the display would normally be hidden."] = "动画时长秒时。直到显示内容可以被正常隐藏之后，结束动画才会播放。"
	L["The type of trigger"] = "触发器类型"
	L["Then "] = "然后"
	L["Thickness"] = "粗细"
	L["This adds %raidMark as text replacements."] = "这将添加 %raidMark 作为文本替换。"
	L["This adds %role, %roleIcon as text replacements."] = "这将添加 %role, %roleIcon 作为文本替换。"
	L["This adds %tooltip, %tooltip1, %tooltip2, %tooltip3 as text replacements."] = "这将添加 %tooltip, %tooltip1, %tooltip2, %tooltip3 作为文本替换。"
	L["This display is currently loaded"] = "此显示内容已加载"
	L["This display is not currently loaded"] = "此显示内容未加载"
	L["This region of type \"%s\" is not supported."] = "不支持域类型\"%s\"。"
	L["This setting controls what widget is generated in user mode."] = "这些设置用来控制在用户模式下生成的控件。"
	L["Tick %s"] = "进度指示 %s"
	L["Tick Mode"] = "进度指示模式"
	L["Tick Placement"] = "进度指示放置"
	L["Time in"] = "时间"
	L["Tiny Icon"] = "微型图标"
	L["To Frame's"] = "到框体的"
	L["To Group's"] = "到组的"
	L["To Personal Ressource Display's"] = "到个人资源显示的"
	L["To Screen's"] = "到屏幕的"
	L["Toggle the visibility of all loaded displays"] = "切换当前已载入图示的可见状态"
	L["Toggle the visibility of all non-loaded displays"] = "切换当前未载入图示的可见状态"
	L["Toggle the visibility of this display"] = "切换此显示内容的可见性"
	L["Tooltip"] = "提示"
	L["Tooltip Content"] = "鼠标提示内容"
	L["Tooltip on Mouseover"] = "鼠标提示"
	L["Tooltip Pattern Match"] = "鼠标提示规则匹配"
	L["Tooltip Text"] = "鼠标提示文本"
	L["Tooltip Value"] = "鼠标提示值"
	L["Tooltip Value #"] = "鼠标提示值 #"
	L["Top"] = "上方"
	L["Top HUD position"] = "顶部 HUD 位置"
	L["Top Left"] = "左上"
	L["Top Right"] = "右上"
	L["Total Angle"] = "最大角度"
	L["Total Time"] = "总时间"
	L["Trigger"] = "触发"
	L["Trigger %d"] = "触发器 %d"
	L["Trigger %s"] = "触发器 %s"
	L["Trigger Combination"] = "触发器组合"
	L["True"] = "真"
	L["Type"] = "类型"
	L["Type 'select' for '%s' requires a values member'"] = "'%s'的类型'select'需要至少一个'values'成员。"
	L["Ungroup"] = "不分组"
	L["Unit"] = "单位"
	L["Unit %s is not a valid unit for RegisterUnitEvent"] = "单位 %s 并不是 RegisterUnitEvent 的有效单位"
	L["Unit Count"] = "单位计数"
	L["Unit Frame"] = "单位框体"
	L["Unit Frames"] = "单位框架"
	L["Unit Name Filter"] = "单位名称过滤方式"
	L["UnitName Filter"] = "单位名称过滤"
	L["Unknown property '%s' found in '%s'"] = "发现'%2$s'的未知属性'%1$s'"
	L["Unlike the start or finish animations, the main animation will loop over and over until the display is hidden."] = "不同于开始或结束动画，主动画将不停循环，直到图示被隐藏。"
	L["Update"] = "更新"
	L["Update Auras"] = "更新光环"
	L["Update Custom Text On..."] = "更新自定义文字于"
	L["URL"] = "URL"
	L["Use Custom Color"] = "使用自定义颜色"
	L["Use Display Info Id"] = "使用显示信息 ID"
	L["Use Full Scan (High CPU)"] = "使用完整扫描（高CPU占用）"
	L["Use nth value from tooltip:"] = "使用第X个鼠标提示的值："
	L["Use SetTransform"] = "使用 SetTransform 方法"
	L["Use Texture"] = "使用材质"
	L["Use tooltip \"size\" instead of stacks"] = "使用来自鼠标提示的层数信息"
	L["Use Tooltip Information"] = "使用鼠标提示信息"
	L["Used in Auras:"] = "在下列光环中被使用："
	L["Used in auras:"] = "在下列光环中被使用："
	L["Uses UnitIsVisible() to check if in range. This is polled every second."] = "使用UnitIsVisible()检查是否在范围内，每秒检查一次。"
	L["Value %i"] = "值 %i"
	L["Values are in normalized rgba format."] = "数值为标准化的 RGBA 格式"
	L["Values:"] = "值："
	L["Version: "] = "版本："
	L["Vertical Align"] = "垂直对齐"
	L["Vertical Bar"] = "垂直条"
	L["View"] = "显示"
	L["Voice"] = "声音"
	L["Whole Area"] = "整个区域"
	L["Width"] = "宽度"
	L["wrapping"] = "折叠"
	L["X Offset"] = "X 偏移"
	L["X Rotation"] = "X轴旋转"
	L["X Scale"] = "宽度比例"
	L["X-Offset"] = "X 偏移"
	L["x-Offset"] = "X偏移"
	L["Y Offset"] = "Y 偏移"
	L["Y Rotation"] = "Y轴旋转"
	L["Y Scale"] = "长度比例"
	L["Yellow Rune"] = "黄色符文"
	L["Yes"] = "是"
	L["y-Offset"] = "Y偏移"
	L["Y-Offset"] = "Y 偏移"
	L["You are about to delete %d aura(s). |cFFFF0000This cannot be undone!|r Would you like to continue?"] = "正在删除 %d 个光环，|cFFFF0000此操作无法被撤销！|r真的要删除吗?"
	L["You are about to delete a trigger. |cFFFF0000This cannot be undone!|r Would you like to continue?"] = "你正在删除一个触发器。|cFFFF0000这个操作无法撤销！|r你要继续吗？"
	L["Your Saved Snippets"] = "已保存片段"
	L["Z Offset"] = "Z 偏移"
	L["Z Rotation"] = "Z轴旋转"
	L["Zoom"] = "缩放"
	L["Zoom In"] = "放大"
	L["Zoom Out"] = "缩小"

