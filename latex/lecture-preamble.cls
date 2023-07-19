\LoadClass{article}
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{lecture-preamble}[custom format for class notes]

% Some basic packages
\usepackage[a4paper, hmarginratio=1:1,twoside, total={5.0in, 9in}]{geometry}
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
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
\RequirePackage{xcolor}

% Other font I sometimes use.
% \RequirePackage{cmbright}

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

% Set shortcuts
\newcommand\N{\ensuremath{\mathbb{N}}}
\newcommand\R{\ensuremath{\mathbb{R}}}
\newcommand\Z{\ensuremath{\mathbb{Z}}}
\newcommand\Q{\ensuremath{\mathbb{Q}}}
\newcommand\C{\ensuremath{\mathbb{C}}}
\renewcommand\O{\ensuremath{\emptyset}}

% Add \contra symbol to denote contradiction
\RequirePackage{stmaryrd} % for \lightning
\newcommand\contra{\scalebox{1.5}{$\lightning$}}

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
\newcounter{dummy}\numberwithin{dummy}{section}
\mdtheorem[nobreak=true]{definition}{Definition}[dummy]
\mdtheorem[nobreak=true]{property}{Property}[dummy]
\mdtheorem[nobreak=true]{result}{Result}[dummy]
\mdtheorem[nobreak=true]{lemma}{Lemma}[dummy]
\mdtheorem[nobreak=true]{propositon}{Proposition}[dummy]
\mdtheorem[nobreak=true]{statement}{Statement}[dummy]
\mdtheorem[nobreak=true]{law}{Law}[dummy]
\mdtheorem[nobreak=true]{postulate}{Postulate}[dummy]
\mdtheorem{conclusion}{Conclusion}
\mdtheorem{extra}{Extra}
\mdtheorem{presumtion}{Presumption}
\newtheorem*{repetition}{Repetition}
\newtheorem*{interlude}{Interlude}
\newtheorem*{note}{Note}
\newtheorem*{observation}{Observation}
% \newtheorem*{oef}{Oefening}
\newtheorem*{remark}{Remark}
\newtheorem*{prectical}{Practical}
\newtheorem*{problem}{Problem}
\newtheorem*{terminology}{Terminology}
\newtheorem*{application}{Application}
\newtheorem*{UsEg}{Usage Example}
\newtheorem*{ask}{Ask}

\newtheorem*{eg}{Example}
\newtheorem*{notation}{Notation}
\newtheorem*{previouslyseen}{As previously seen}
\newtheorem*{observe}{Observe}
\newtheorem*{intuition}{Intuition}
\mdtheorem[nobreak=true]{prop}{Proposition}
\mdtheorem[nobreak=true]{theorem}{Theorem}
\mdtheorem[nobreak=true]{corollary}{Corollary}
\renewcommand\qedsymbol{QED}



% End example and intermezzo environments with a small diamond (just like proof
% environments end with a small square)
\RequirePackage{etoolbox}
\AtEndEnvironment{UsEg}{\null\hfill$\diamond$}%
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
\newcommand{\oefening}[1]{%
	\def\@oefening{#1}%
	\subsection*{Oefening #1}
}

\newcommand{\suboefening}[1]{%
	\subsubsection*{Oefening \@oefening.#1}
}


% \lecture starts a new lecture (les in dutch)
%
% Usage:
% \lecture{1}{di 12 feb 2019 16:00}{Inleiding}
%
% This adds a section heading with the number / title of the lecture and a
% margin paragraph with the date.

% I use \dateparts here to hide the year (2019). This way, I can easily parse
% the date of each lecture unambiguously while still having a human-friendly
% short format printed to the pdf.

\RequirePackage{xifthen}
\def\testdateparts#1{\dateparts#1\relax}
\def\dateparts#1 #2 #3 #4 #5\relax{
	\marginpar{\small\textsf{\mbox{#1 #2 #3 #5}}}
}

\def\@lecture{}%
\newcommand{\lecture}[3]{
	\ifthenelse{\isempty{#3}}{%
		\def\@lecture{Lecture #1}%
	}{%
		\def\@lecture{Lecture #1: #3}%
	}%
	\subsection*{\@lecture}
	\marginpar{\small\textsf{\mbox{#2}}}
}



% These are the fancy headers
\RequirePackage{fancyhdr}
\pagestyle{fancy}

% LE: left even
% RO: right odd
% CE, CO: center even, center odd
% My name for when I print my lecture notes to use for an open book exam.
\fancyhead[LE,RO]{Mark Volin}
\fancyhead[RO,LE]{\@lecture} % Right odd,  Left even
\fancyhead[RE,LO]{}          % Right even, Left odd

\fancyfoot[RO,LE]{\thepage}  % Right odd,  Left even
\fancyfoot[RE,LO]{}          % Right even, Left odd
\fancyfoot[C]{\leftmark}     % Center

\makeatother


% Todonotes and inline notes in fancy boxes
\RequirePackage{todonotes}
\RequirePackage{tcolorbox}


% Make boxes breakable
\tcbuselibrary{breakable}

% Verbetering is correction in Dutch
% Usage: 
% \begin{verbetering}
%     Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod
%     tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At
%     vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren,
%     no sea takimata sanctus est Lorem ipsum dolor sit amet.
% \end{verbetering}
\newenvironment{verbetering}{\begin{tcolorbox}[
			arc=0mm,
			colback=white,
			colframe=green!60!black,
			title=Opmerking,
			fonttitle=\sffamily,
			breakable
		]}{\end{tcolorbox}}

% Noot is note in Dutch. Same as 'verbetering' but color of box is different
\newenvironment{noot}[1]{\begin{tcolorbox}[
			arc=0mm,
			colback=white,
			colframe=white!60!black,
			title=#1,
			fonttitle=\sffamily,
			breakable
		]}{\end{tcolorbox}}




% Figure support as explained in my blog post.
\RequirePackage{import}
\RequirePackage{xifthen}
\RequirePackage{pdfpages}
\RequirePackage{transparent}
\newcommand{\incfig}[1]{%
	\def\svgwidth{\columnwidth}
	\import{./figures/}{#1.pdf_tex}
}

% Fix some stuff
% %http://tex.stackexchange.com/questions/76273/multiple-pdfs-with-page-group-included-in-a-single-page-warning
\pdfsuppresswarningpagegroup=1
\ExplSyntaxOn
\msg_redirect_name:nnn { siunitx } { physics-pkg } { none }
\ExplSyntaxOff

% My name
\author{Mark Volin}
\date{}
\hfuzz=5.002pt
