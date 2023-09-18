\LoadClass[12pt,fleqn]{book}
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{lecture-preamble}[custom format for class notes]

% Some basic packages
\RequirePackage[a4paper, hmarginratio=1:1,twoside, total={6in, 9.5in}]{geometry}
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage[hidelinks,bookmarks]{hyperref}
\RequirePackage{textcomp}
\RequirePackage{newunicodechar}
\RequirePackage[english,spanish]{babel}
\RequirePackage{url}
\RequirePackage{graphicx}
% \RequirePackage{float}
\RequirePackage{booktabs}
\RequirePackage{enumitem}
\RequirePackage{lipsum}
\RequirePackage{floatrow}
\pdfminorversion=7
% Don't indent paragraphs, leave some space between them
\RequirePackage{parskip}
% Hide page number when page is empty
\RequirePackage{emptypage}
\RequirePackage{subcaption}
\RequirePackage{multicol}
\RequirePackage[divpsnames,x11names]{xcolor}
\RequirePackage{appendix}
\AtBeginEnvironment{subappendices}{%
\chapter*{Complements}
\addcontentsline{toc}{chapter}{Complements to Chapter \thechapter}
\counterwithin{figure}{section}
\counterwithin{table}{section}
}
\AtEndEnvironment{subappendices}{%
\counterwithout{figure}{section}
\counterwithin{figure}{chapter}
\counterwithout{table}{section}
\counterwithin{table}{chapter}
}

\RequirePackage[overload]{empheq}
% Other font I sometimes use.
% \RequirePackage{cmbright}

% Math stuff
\RequirePackage{amsmath}
\RequirePackage{amsfonts, mathtools, amsthm, amssymb}
% Fancy script capitals
\RequirePackage{mathrsfs}
\RequirePackage{multirow}
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

\RequirePackage[nodisplayskipstretch]{setspace}

\RequirePackage{alphalph}
\RequirePackage{moreenum}
\setcounter{tocdepth}{2}
\setcounter{secnumdepth}{4}
\renewcommand\thechapter{\Roman{chapter}}
\renewcommand\thesection{\Alph{section}}
\renewcommand\thesubsection{\thesection-\arabic{subsection}}
\renewcommand\thesubsubsection{\thesubsection-\alph{subsection}}
% \renewcommand{\theenumi}{\textit{\roman{enumi}}}
% \renewcommand{\labelenumi}{(\theenumi)}
\makeatletter
\renewcommand{\theparagraph}{\greek{paragraph}.}
\makeatother
\RequirePackage{titlesec}
\RequirePackage{titling}
\RequirePackage[T1]{fontenc}
\titleformat*{\section}{\fontfamily{cmss}\selectfont\large\bfseries}
\titleformat*{\subsection}{\fontfamily{cmss}\selectfont\small\bfseries}
\titleformat*{\subsubsection}{\fontfamily{cmss}\selectfont\footnotesize\bfseries}
\titleformat*{\paragraph}{\normalsize\itshape}
\titleformat{\paragraph}
{\normalfont\normalsize\itshape}{\theparagraph}{1em}{}
\titlespacing*{\paragraph}
{0pt}{3.25ex plus 1ex minus .2ex}{1.5ex plus .2ex}
\makeatletter
\renewcommand\p@figure{\expandafter\counter@parenthesize}
\newcommand\counter@parenthesize[1]{Figure #1}
\makeatother
\let\Chaptermark\chaptermark
\def\chaptermark#1{\def\Chaptername{#1}\Chaptermark{#1}}
\let\Sectionmark\sectionmark
\def\sectionmark#1{\def\Sectionname{#1}\Sectionmark{#1}}
\let\Subsectionmark\subsectionmark
\def\subsectionmark#1{\def\Subsectionname{#1}\Subsectionmark{#1}}
\let\Subsubsectionmark\subsubsectionmark
\def\subsubsectionmark#1{\def\Subsubsectionname{#1}\Subsubsectionmark{#1}}

% Set shortcuts
\RequirePackage{bbold}
\newcommand\I{\ensuremath{\mathbb{1}}}
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
\newcommand\const{\ensuremath{\text{const.}}}
\let\temp\phi
\let\phi\varphi
\let\varphi\temp
% Add \contra symbol to denote contradiction
\RequirePackage{stmaryrd} % for \lightning
\newcommand\contra{\scalebox{1.5}{$\lightning$}}

\newcommand*{\widebox}[2][0.5em]{\fbox{\vspace*{10in}\hspace{#1}$\displaystyle #2$\hspace{#1}}}
\newcommand{\eqname}[1]{\tag*{#1}}
\RequirePackage{empheq}
\newcommand*\widefbox[1]{\fbox{\hspace{0.5em}#1\hspace{0.5em}}}
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


\makeatletter
\newtheoremstyle{swapdef}
  {\parsep}   % ABOVESPACE
  {\topsep}   % BELOWSPACE
  {\upshape}  % BODYFONT
  {-5pt}       % INDENT (empty value is the same as 0pt)
  {\bfseries} % HEADFONT
  {.}         % HEADPUNCT
  {5pt plus 1pt minus 1pt} % HEADSPACE
  {\thmnumber{#2} \thmname{#1}\thmnote{#3}} % CUSTOM-HEAD-SPEC
\newtheoremstyle{para}
  {\topsep}   % ABOVESPACE
  {\parsep+\parsep}   % BELOWSPACE
  {\upshape}  % BODYFONT
  {0pt}       % INDENT (empty value is the same as 0pt)
  {\bfseries} % HEADFONT
  {\hfill\\ \\}         % HEADPUNCT
  {5pt plus 1pt minus 1pt} % HEADSPACE
  {\thmname{#1} \thmnumber{#2}\@ifnotempty{#3}{: \normalfont\thmnote{#3}}} % CUSTOM-HEAD-SPEC
\newtheoremstyle{separated}
  {\topsep\hr}   % ABOVESPACE
  {\parsep+\parsep}   % BELOWSPACE
  {\upshape}  % BODYFONT
  {0pt}       % INDENT (empty value is the same as 0pt)
  {\bfseries} % HEADFONT
  {\hfill\\ \\}         % HEADPUNCT
  {5pt plus 1pt minus 1pt} % HEADSPACE
  {\thmname{#1}\thmnumber{#2}\@ifnotempty{#3}{ \normalfont\itshape(\thmnote{#3})}} % CUSTOM-HEAD-SPEC
\makeatother

\theoremstyle{para}
% Environments
\makeatother
% For box around Definition, Theorem, \ldots
\RequirePackage{mdframed}
\mdfsetup{skipabove=1em,skipbelow=1em}
\mdtheorem[nobreak=true]{definition}{Definition}
\mdtheorem[nobreak=true]{property}{Property}
\mdtheorem[nobreak=true]{result}{Result}
\mdtheorem[nobreak=true]{lemma}{Lemma}[section]
\mdtheorem[nobreak=true]{proposition}{Proposition}
\mdtheorem[nobreak=true]{statement}{Statement}[section]
\mdtheorem[nobreak=true]{law}{Law}
\mdtheorem[nobreak=true]{postulate}{Postulate}[section]
\mdtheorem{conclusion}{Conclusion}
\mdtheorem{extra}{Extra}
\mdtheorem{presumption}{Presumption}
\newtheorem*{repetition}{Repetition}
\newtheorem*{interlude}{Interlude}
\newtheorem*{note-}{Note}
\theoremstyle{swapdef}
\newtheorem*{terminology}{Terminology}
\newtheorem*{remark}{Remark}
\newtheorem*{observation}{Observation}
\newtheorem*{practical}{Practical}
\newtheorem*{problem}{Problem}
\newtheorem*{application}{Application}
\newtheorem*{usage-example}{Usage Example}
\newtheorem*{ask}{Ask}

\theoremstyle{separated}
\theoremstyle{para}
\newtheorem{example}{Example}[chapter]
\AtBeginEnvironment{example}{\renewcommand\thechapter{{\rmfamily\arabic{chapter}}}}
\newtheorem*{notation}{Notation}
\newtheorem*{previously-seen}{As previously seen}
\newtheorem*{observe}{Observe}
\newtheorem*{intuition}{Intuition}
\mdtheorem[nobreak=true]{prop}{Proposition}[section]
\mdtheorem[nobreak=true]{theorem}{Theorem}[section]
\mdtheorem[nobreak=true]{corollary}{Corollary}[theorem]
\renewcommand\qedsymbol{QED}
\setlist[enumerate,1]{label={\upshape(\roman*)}}

% \renewcommand\vb{\vec}

\RequirePackage{mathtools}
\DeclarePairedDelimiter{\exv}{\langle}{\rangle}

\makeatletter
\newtheoremstyle{indented}
  {3em}% space before
  {3pt}% space after
  {\addtolength{\@totalleftmargin}{2em}
   \addtolength{\linewidth}{-2em}
   \parshape 1 2em \linewidth}% body font
  {}% indent
  {\bfseries\itshape}% header font
  {:}% punctuation
  {\newline}% after theorem header
  {}% header specification (empty for default
\makeatother
\theoremstyle{indented}
\newtheorem*{indented}{Comment}
\newenvironment{cmt}[1][]{% 
\begin{indented}[#1]\leavevmode\vspace{-0.25\baselineskip}%
}{\end{indented}}
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
\newcommand{\exercise}[2]{%
  \def\@exercise{#1}%
  \subsection*{Exercise #1: \@ifnotempty{#2}{\normalfont #2}
 }}

\newcommand{\subexercise}[1]{%
	\subsubsection*{Exercise \@exercise.#1}
}

\newcommand{\solution}[1]{%
  \subsubsection*{Solution\@ifnotempty{#1}{\@exercise.#1}}
}
\addtolength{\jot}{0.5em}
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




% These are the fancy headers
\RequirePackage{fancyhdr}
\RequirePackage{titlesec}
\pagestyle{fancy}

\titleformat{\chapter}[display]
  {\normalfont\huge\bfseries}
  {\chaptertitlename\ \thechapter}
  {20pt}
  {\LARGE}
\renewcommand{\chaptermark}[1]{\markboth{\chaptername\ \thechapter:\ #1}{}}
\renewcommand{\sectionmark}[1]{\markright{\thesection\ #1}}
% LE: left even
% RO: right odd
% CE, CO: center even, center odd
% My name for when I print my lecture notes to use for an open book exam.
\fancyhead[LE]{\footnotesize \leftmark} % Right odd,  Left even
\fancyhead[RO]{\footnotesize \rightmark}          % Right even, Left odd
\fancyhead[LO,RE]{ }          % Right even, Left odd

\fancyfoot[RO,LE]{\thepage}  % Right odd,  Left even
\fancyfoot[RE,LO]{}          % Right even, Left odd
\fancyfoot[C]{ }
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
\newenvironment{correction}{\begin{tcolorbox}[
			arc=0mm,
			colback=white,
			colframe=green!60!black,
			title=Correction,
			fonttitle=\sffamily,
			breakable
		]}{\end{tcolorbox}}

% Noot is note in Dutch. Same as 'verbetering' but color of box is different
\newenvironment{note}[1]{\begin{tcolorbox}[
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
	\import{}{#1.pdf_tex}
}



% Fix some stuff
% %http://tex.stackexchange.com/questions/76273/multiple-pdfs-with-page-group-included-in-a-single-page-warning
\pdfsuppresswarningpagegroup=1
\ExplSyntaxOn
\msg_redirect_name:nnn { siunitx } { physics-pkg } { none }
\ExplSyntaxOff

\setstretch{-2}
% My name
\author{Mark Volin}
\date{}
\hfuzz=5.002pt
\spacing{1.05}
\makeatletter
\g@addto@macro\normalsize{%
  \setlength\abovedisplayskip{-10pt}
  \setlength\belowdisplayskip{10pt}
  \setlength\abovedisplayshortskip{-15pt}
  \setlength\belowdisplayshortskip{00pt}
}
\makeatother
