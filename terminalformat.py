class TerminalFormat:
	"""A terminal output helper class"""

	def __init__(self):
		self.isBold = False
		self.isUnderline = False
	
	_info = '\033[94m' 		# blue
	_success = '\033[92m' 	# green
	_warning = '\033[93m' 	# orange
	_error = '\033[91m' 		# red
	_emphasis = '\033[95m'	# purple
	_bold = '\033[1m'
	_underline = '\033[4m'
	_reset = '\033[0m'

	@property
	def bold(self):
		self.isBold = True
		return self

	@property
	def underline(self):
		self.isUnderline = True
		return self


	def __parse__(self, color, msg):
		fonTerminalFormatlags = ''

		if self.isBold:
			fonTerminalFormatlags += TerminalFormat._bold
			self.isBold = False

		if self.isUnderline:
			fonTerminalFormatlags += TerminalFormat._underline
			self.isUnderline = False

		return color+fonTerminalFormatlags+msg+TerminalFormat._reset

	
	def info(self, msg):
		return self.__parse__(TerminalFormat._info, msg)
	
	def success(self, msg):
		return self.__parse__(TerminalFormat._success, msg)	

	def warning(self, msg):
		return self.__parse__(TerminalFormat._warning, msg)
	
	def error(self, msg):
		return self.__parse__(TerminalFormat._error, msg)
	
	def emphasis(self, msg):
		return self.__parse__(TerminalFormat._emphasis, msg)

tf = TerminalFormat()