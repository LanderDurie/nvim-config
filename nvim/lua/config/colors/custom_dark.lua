return {
	"custom_dark",
	lazy = false,
	priority = 1000,
	config = function()
		local hl = vim.api.nvim_set_hl

		-- Base background/foreground
		vim.o.background = "dark"

		-- Text elements
		hl(0, "Normal", { fg = "#F7F7F1", bg = "#21211A" })
		hl(0, "LineNr", { fg = "#BDBDBD", bg = "#2A2A25" })
		hl(0, "Comment", { fg = "#80E300", italic = true })
		hl(0, "CommentTag", { fg = "#74705D", bold = true })
		hl(0, "Excluded", { fg = "#74705D" })
		hl(0, "String", { fg = "#A5ED29" })
		hl(0, "Number", { fg = "#A5ED29" })

		-- Keywords
		hl(0, "Type", { fg = "#61A7FF" })
		hl(0, "Operator", { fg = "#FF4444" })
		hl(0, "Selection", { fg = "#FF4444" })
		hl(0, "Iteration", { fg = "#FF4444" })
		hl(0, "Jump", { fg = "#FF4444" })
		hl(0, "Context", { fg = "#FF4444" })
		hl(0, "Exception", { fg = "#FF4444" })
		hl(0, "Modifiers", { fg = "#FF4444" })
		hl(0, "Constants", { fg = "#A5ED29" })
		hl(0, "Void", { fg = "#FF4444" })
		hl(0, "Namespace", { fg = "#FF4343" })
		hl(0, "Property", { fg = "#FF4444" })
		hl(0, "Declaration", { fg = "#FF4444" })
		hl(0, "Parameter", { fg = "#FF4444" })
		hl(0, "OperatorDeclaration", { fg = "#FF4444" })
		hl(0, "OtherKeyword", { fg = "#9D00FF" })

		-- User types
		hl(0, "UserType", { fg = "#61A7FF" })
		hl(0, "UserTypeEnum", { fg = "#61A7FF" })
		hl(0, "UserTypeInterface", { fg = "#61A7FF" })
		hl(0, "UserTypeDelegate", { fg = "#61A7FF" })
		hl(0, "UserTypeValue", { fg = "#61A8FF" })
		hl(0, "UserTypeParam", { fg = "#FFFFFF" })

		-- User fields/properties/methods/events
		hl(0, "UserFieldUsage", { fg = "#FFFFFF" })
		hl(0, "UserFieldDecl", { fg = "#FFFFFF" })
		hl(0, "UserPropUsage", { fg = "#FFFFFF" })
		hl(0, "UserPropDecl", { fg = "#FFFFFF" })
		hl(0, "UserEventUsage", { fg = "#FF5900" })
		hl(0, "UserEventDecl", { fg = "#FF5900" })
		hl(0, "UserMethodUsage", { fg = "#FF4343" })
		hl(0, "UserMethodDecl", { fg = "#FF4343" })
		hl(0, "UserVarDecl", { fg = "#FFFFFF" })

		-- HTML/CSS/Script
		hl(0, "HtmlAttrName", { fg = "#F7F7F1" })
		hl(0, "CssKeyword", { fg = "#F92570", bold = true })
		hl(0, "ScriptComment", { fg = "#74705D" })
		hl(0, "ScriptKeyword", { fg = "#6ECC00" })
	end,
}
