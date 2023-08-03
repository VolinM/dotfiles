\LoadClass{article}
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{simple-template}[custom format for class notes]


% Some basic packages
\RequirePackage[a4paper, hmarginratio=1:1,twoside, total={5.0in, 9in}]{geometry}
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage[hidelinks,bookmarks]{hyperref}
\RequirePackage{textcomp}
\RequirePackage[english]{babel}
\RequirePackage{url}
\RequirePackage{graphicx}
\RequirePackage{float}
\RequirePackage{booktabs}
\RequirePackage{enumitem}
\RequirePackage{lipsum}
\pdfminorversion=7
% Don't indent paragraphs, leave some space between them
\RequirePackage{parskip}
% Hide page number when page is empty
\RequirePackage{emptypage}
\RequirePackage{subcaption}
\RequirePackage{multicol}
\RequirePackage[divpsnames,x11names]{xcolor}
% Margins
\topmargin=-0.45in
\evensidemargin=0in
\oddsidemargin=0in
\textwidth=6.5in
\textheight=9.0in
\headsep=0.25in

% Math stuff
\RequirePackage{amsmath, amsfonts, mathtools, amsthm, amssymb}
% Fancy script capitals
\RequirePackage{mathrsfs}
% Cancel symbols
\RequirePackage{cancel}
% Bold math
\RequirePackage{bm}
% si unitx
\RequirePackage{siunitx}
% Physics package
\RequirePackage{physics}
\AtBeginDocument{\RenewCommandCopy\qty\SI}
% Fancy Integrals
\RequirePackage{esint}
% Easily typeset systems of equations (French package)
\RequirePackage{systeme}

\numberwithin{equation}{section}
\numberwithin{figure}{section}

% Set shortcuts
\newcommand\N{\ensuremath{\mathbb{N}}}
\newcommand\R{\ensuremath{\mathbb{R}}}
\newcommand\Z{\ensuremath{\mathbb{Z}}}
\newcommand\Q{\ensuremath{\mathbb{Q}}}
\newcommand\C{\ensuremath{\mathbb{C}}}
\renewcommand\O{\ensuremath{\emptyset}}
\renewcommand\iff{\ensuremath{\Leftrightarrow}}
\newcommand\Lagr{\ensuremath{\mathcal{L}}}
\newcommand\Lapl{\ensuremath{\mathscr{C}}}
\newcommand\Fourier{\ensuremath{\mathscr{F}}}


% Add \contra symbol to denote contradiction
\RequirePackage{stmaryrd} % for \lightning
\newcommand\contra{\scalebox{1.5}{$\lightning$}}

\newcommand*{\widebox}[2][1em]{\fbox{\vspace*{10in}\hspace{#1}$\displaystyle #2$\hspace{#1}}}
\newcommand{\eqname}[1]{\tag*{#1}}

% Command for short corrections
% Usage: 1+1=\correct{3}{2}
\definecolor{correct}{HTML}{009900}
\newcommand\correct[2]{\ensuremath{\:}{\color{red}{#1}}\ensuremath{\to }{\color{correct}{#2}}\ensuremath{\:}}
\newcommand\green[1]{{\color{correct}{#1}}}


% horizontal rule
\newcommand\hr{
	\noindent\rule[0.5ex]{\linewidth}{0.5pt}
}

% hide parts
\newcommand\hide[1]{}


% Environments
\makeatother
% For box around Definition, Theorem, \ldots
\RequirePackage{mdframed}
\mdfsetup{skipabove=1em,skipbelow=0em}
\theoremstyle{definition}
\mdtheorem[nobreak=true]{definition}{Definition}[section]
\mdtheorem[nobreak=true]{property}{Property}[definition]
\mdtheorem[nobreak=true]{result}{Result}[definition]
\mdtheorem[nobreak=true]{lemma}{Lemma}[section]
\mdtheorem[nobreak=true]{proposition}{Proposition}[section]
\mdtheorem[nobreak=true]{statement}{Statement}[section]
\mdtheorem[nobreak=true]{law}{Law}[section]
\mdtheorem[nobreak=true]{postulate}{Postulate}[section]
\mdtheorem{conclusion}{Conclusion}
\mdtheorem{extra}{Extra}
\mdtheorem{presumption}{Presumption}
\newtheorem*{repetition}{Repetition}
\newtheorem*{interlude}{Interlude}
\newtheorem*{note-}{Note}
\newtheorem*{observation}{Observation}
\newtheorem*{remark}{Remark}
\newtheorem*{practical}{Practical}
\newtheorem*{problem}{Problem}
\newtheorem*{terminology}{Terminology}
\newtheorem*{application}{Application}
\newtheorem*{usage-example}{Usage Example}
\newtheorem*{ask}{Ask}

\newtheorem*{example}{Example}
\newtheorem*{notation}{Notation}
\newtheorem*{previously-seen}{As previously seen}
\newtheorem*{observe}{Observe}
\newtheorem*{intuition}{Intuition}
\mdtheorem[nobreak=true]{prop}{Proposition}[section]
\mdtheorem[nobreak=true]{theorem}{Theorem}[section]
\mdtheorem[nobreak=true]{corollary}{Corollary}[theorem]
\renewcommand\qedsymbol{QED}



% End example and intermezzo environments with a small diamond (just like proof
% environments end with a small square)
\RequirePackage{etoolbox}
\AtEndEnvironment{usage-example}{\null\hfill$\diamond$}%
\AtEndEnvironment{interlude}{\null\hfill$\diamond$}%
% \AtEndEnvironment{opmerking}{\null\hfill$\diamond$}%

% Fix some spacing
% http://tex.stackexchange.com/questions/22119/how-can-i-change-the-spacing-before-theorems-with-amsthm
\makeatletter
\def\thm@space@setup{%
	\thm@preskip=\parskip \thm@postskip=0pt
}



% Exercise 
% Usage:
% \oefening{5}
% \suboefening{1}
% \suboefening{2}
% \suboefening{3}
% gives
% Oefening 5
%   Oefening 5.1
%   Oefening 5.2
%   Oefening 5.3
\newcommand{\exercise}[1]{%
	\def\@exercise{#1}%
	\subsection*{Exercise #1}
}

\newcommand{\subexercise}[1]{%
	\subsubsection*{Exercise \@exercise.#1}
}

\newcommand{\solution}[1]{%
	\subsubsection*{Solution \@exercise.#1}
}


\pdfsuppresswarningpagegroup=1
\ExplSyntaxOn
\msg_redirect_name:nnn { siunitx } { physics-pkg } { none }
\ExplSyntaxOff

\usepackage{pgfplots}

\usepackage{xcolor}
\definecolor{nord0}{RGB}{46, 52, 64}
\definecolor{nord1}{RGB}{59, 66, 82}
\definecolor{nord3}{RGB}{104, 112, 122}
\definecolor{nord4}{RGB}{133, 153, 168}
\definecolor{nord6}{RGB}{216, 222, 233}
\definecolor{nord7}{RGB}{229, 233, 240}
\definecolor{nord8}{RGB}{236, 239, 244}
\definecolor{nord9}{RGB}{153, 171, 190}
\definecolor{nord11}{RGB}{191, 97, 106}
\definecolor{nord12}{RGB}{208, 135, 112}
\definecolor{nord14}{RGB}{129, 161, 193}

% Inverted Nord colors for Zathura
\definecolor{nord0_zathura}{RGB}{236, 239, 244}
\definecolor{nord1_zathura}{RGB}{229, 233, 240}
\definecolor{nord3_zathura}{RGB}{171, 178, 191}
\definecolor{nord4_zathura}{RGB}{142, 163, 186}
\definecolor{nord6_zathura}{RGB}{46, 52, 64}
\definecolor{nord7_zathura}{RGB}{59, 66, 82}
\definecolor{nord8_zathura}{RGB}{59, 66, 82}
\definecolor{nord9_zathura}{RGB}{153, 171, 190}
\definecolor{nord11_zathura}{RGB}{191, 97, 106}
\definecolor{nord12_zathura}{RGB}{208, 135, 112}
\definecolor{nord14_zathura}{RGB}{133, 153, 168}
% listings
\usepackage{listings}
\usepackage{FiraMono}

% General Setting of listings
\lstset{
  aboveskip=1em,
  breaklines=true,
  abovecaptionskip=-6pt,
  captionpos=b,
  escapeinside={\%*}{*)},
  frame=single,
  numbers=left,
  numbersep=15pt,
  numberstyle=\tiny,
}

% 0. Basic Color Theme
\lstdefinestyle{colored}{ %
  basicstyle=\ttfamily,
  backgroundcolor=\color{white},
  commentstyle=\color{green}\itshape,
  keywordstyle=\color{blue}\bfseries\itshape,
  stringstyle=\color{red},
}
% 1. General Python Keywords List
\lstdefinelanguage{PythonPlus}[]{Python}{
  morekeywords=[1]{,as,assert,nonlocal,with,yield,self,True,False,None,} % Python builtin
  morekeywords=[2]{,__init__,__add__,__mul__,__div__,__sub__,__call__,__getitem__,__setitem__,__eq__,__ne__,__nonzero__,__rmul__,__radd__,__repr__,__str__,__get__,__truediv__,__pow__,__name__,__future__,__all__,}, % magic methods
  morekeywords=[3]{,object,type,isinstance,copy,deepcopy,zip,enumerate,reversed,list,set,len,dict,tuple,range,xrange,append,execfile,real,imag,reduce,str,repr,}, % common functions
  morekeywords=[4]{,Exception,NameError,IndexError,SyntaxError,TypeError,ValueError,OverflowError,ZeroDivisionError,}, % errors
  morekeywords=[5]{,ode,fsolve,sqrt,exp,sin,cos,arctan,arctan2,arccos,pi, array,norm,solve,dot,arange,isscalar,max,sum,flatten,shape,reshape,find,any,all,abs,plot,linspace,legend,quad,polyval,polyfit,hstack,concatenate,vstack,column_stack,empty,zeros,ones,rand,vander,grid,pcolor,eig,eigs,eigvals,svd,qr,tan,det,logspace,roll,min,mean,cumsum,cumprod,diff,vectorize,lstsq,cla,eye,xlabel,ylabel,squeeze,}, % numpy / math
}
% 2. New Language based on Python
\lstdefinelanguage{PyBrIM}[]{PythonPlus}{
  emph={d,E,a,Fc28,Fy,Fu,D,des,supplier,Material,Rectangle,PyElmt},
}
% 3. Extended theme
\lstdefinestyle{colorEX}{
  aboveskip=1em,
  breaklines=true,
  abovecaptionskip=-6pt,
  captionpos=b,
  escapeinside={\%*}{*)},
  frame=single,
  numbers=left,
  numbersep=15pt,
  numberstyle=\tiny,
  basicstyle=\ttfamily\footnotesize,
  keywordstyle=\color{nord9},
  commentstyle=\color{nord12}, % Set comments to a more contrasting color
  stringstyle=\color{nord14},
  emphstyle=\color{nord11},
  backgroundcolor=\color{white}, % Set background color to Nord's background
}
\lstnewenvironment{python}{\lstset{style=colorEx, language=PythonPlus}}{}
