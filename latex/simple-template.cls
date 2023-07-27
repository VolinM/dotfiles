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
