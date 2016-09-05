" Highlight some useful doxygen documentation
syn region cDoxygen oneline matchgroup=cComment start='\/\/\/\s*@brief\s\+' end='$'
syn region cDoxygen oneline matchgroup=cComment start='\/\/\/\s*@tparam\s\+' end='\(\s.*$\|$\)'
syn region cDoxygen oneline matchgroup=cComment start='\/\/\/\s*@param\(\[\(\|in\|out\|inout\)\]\)\=\s\+' end='\(\s.*$\|$\)'
hi default link cDoxygen SpecialComment
