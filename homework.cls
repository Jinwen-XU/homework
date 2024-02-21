%%
%% Copyright (C) 2023-2024 by Jinwen XU
%% ------------------------------------
%%
%% This file may be distributed and/or modified under the conditions of
%% the LaTeX Project Public License, either version 1.3c of this license
%% or (at your option) any later version.  The latest version of this
%% license is in:
%%
%%    http://www.latex-project.org/lppl.txt
%%
\NeedsTeXFormat{LaTeX2e}[2022-06-01]
\ProvidesExplClass
  {homework}
  {2024/02/21} {}
  {Document class for writing homework}

\keys_define:nn { homework }
  {
    , logo          .tl_set:N     = \l__homework_logo_name_tl
    , logo          .initial:n    = { }
    , logo-height   .dim_set:N    = \l__homework_logo_height_dim
    , logo~height   .dim_set:N    = \l__homework_logo_height_dim
    , logo height   .dim_set:N    = \l__homework_logo_height_dim
    , logo-width    .dim_set:N    = \l__homework_logo_width_dim
    , logo~width    .dim_set:N    = \l__homework_logo_width_dim
    , logo width    .dim_set:N    = \l__homework_logo_width_dim

    , formal-title  .bool_set:N   = \l__homework_formal_title_bool
    , formal-title  .initial:n    = { false }
    , formal~title  .bool_set:N   = \l__homework_formal_title_bool
    , formal title  .bool_set:N   = \l__homework_formal_title_bool

    , colored-solution .tl_set:N  = \l__homework_solution_color_tl
    , colored-solution .initial:n = { main-text }
    , colored-solution .default:n = { cyan!50!blue!90!main-text }
    , colored~solution .tl_set:N  = \l__homework_solution_color_tl
    , colored~solution .default:n = { cyan!50!blue!90!main-text }
    , colored solution .tl_set:N  = \l__homework_solution_color_tl
    , colored solution .default:n = { cyan!50!blue!90!main-text }
    , colored-answer   .tl_set:N  = \l__homework_solution_color_tl
    , colored-answer   .default:n = { cyan!50!blue!90!main-text }
    , colored~answer   .tl_set:N  = \l__homework_solution_color_tl
    , colored~answer   .default:n = { cyan!50!blue!90!main-text }
    , colored answer   .tl_set:N  = \l__homework_solution_color_tl
    , colored answer   .default:n = { cyan!50!blue!90!main-text }

    , hide-solution .bool_set:N   = \l__homework_hide_solution_bool
    , hide-solution .initial:n    = { false }
    , hide~solution .bool_set:N   = \l__homework_hide_solution_bool
    , hide solution .bool_set:N   = \l__homework_hide_solution_bool
    , hide-answer   .bool_set:N   = \l__homework_hide_solution_bool
    , hide~answer   .bool_set:N   = \l__homework_hide_solution_bool
    , hide answer   .bool_set:N   = \l__homework_hide_solution_bool

    , remove-qed    .bool_set:N   = \l__homework_no_qed_bool
    , remove-qed    .initial:n    = { false }
    , remove~qed    .bool_set:N   = \l__homework_no_qed_bool
    , remove qed    .bool_set:N   = \l__homework_no_qed_bool

    , unknown       .code:n       = {
                                      \PassOptionsToClass { \CurrentOption } { minimart }
                                      \PassOptionsToClass { \CurrentOption } { einfart }
                                      \PassOptionsToPackage { \CurrentOption } { ProjLib }
                                    }
  }
\ProcessKeyOptions [ homework ]

%%================================
%%  Load the base class
%%================================

\sys_if_engine_pdftex:TF
  {
    \bool_if:NF \l__homework_no_qed_bool
      {
        \PassOptionsToClass { theorem with qed } { minimart }
      }
    \PassOptionsToClass { use indent = false } { minimart }
    \LoadClass { minimart }
  }
  {
    \bool_if:NF \l__homework_no_qed_bool
      {
        \PassOptionsToClass { theorem with qed } { einfart }
      }
    \PassOptionsToClass { use indent = false } { einfart }
    \LoadClass { einfart }
  }

\RequirePackage { ProjLib }

%%================================
%%  Print the title
%%================================

\newcommand\@pretitle{}

\NewDocumentCommand \pretitle { +m }
  {
    \renewcommand{\@pretitle}{#1}
  }

\renewcommand{\@maketitle}
  {
    \LocallyStopLineNumbers

    % Insert the pretitle
    \noindent{\@pretitle}\par

    \bool_if:NTF \l__homework_formal_title_bool
      {
        \bigskip
        \begin{center}
          \let\footnote\thanks
          {\minimalist_bfseries:\minimalist_sffamily:\minimalist_scshape:\Large\@title}\\\bigskip
          \color{main-text!80!paper}
          {\small\@author}
          \par\smallskip\vspace{-\parskip}
          {\small\@date}
        \end{center}
        \projlib_author_if_content_empty:nT { \@date } { \medskip }
        \medskip\par
      }
      {
        \begin{tcolorbox}[
          enhanced~jigsaw, sharp~corners,
          sidebyside,
          % sidebyside~adapt=left,
          lefthand~width = .33\linewidth,
          lower~separated = false,
          toprule = .75pt, bottomrule = .75pt,
          leftrule = 0pt, rightrule = 0pt,
          boxsep = 0pt,
          top = 1.5ex, bottom = 1.5ex,
          left = 0pt, right = 0pt,
          colframe = main-text!27!paper,
          colback = paper,
        ]
          \tl_if_empty:NF \l__homework_logo_name_tl
            {
              \dim_compare:nNnTF { \l__homework_logo_height_dim } < { 1pt }
                {% height not given
                  \dim_compare:nNnTF { \l__homework_logo_width_dim } < { 1pt }
                    {% width not given
                      \includegraphics [ height = 1.5cm ] { \l__homework_logo_name_tl }
                    }
                    {% width given
                      \includegraphics [ width = \l__homework_logo_width_dim ] { \l__homework_logo_name_tl }
                    }
                }
                {% height given
                  \includegraphics [ height = \l__homework_logo_height_dim ] { \l__homework_logo_name_tl }
                }
            }
          \tcblower
          \begin{flushright}
            \let\footnote\thanks
            {\minimalist_bfseries:\minimalist_sffamily:\@title}\\\medskip
            \color{main-text!80!paper}
            {\small\minimalist_scshape:\@author}
            \par\vspace{-\parskip}\vspace{2pt}
            {\small\@date}
          \end{flushright}
          \vspace{-2pt}
        \end{tcolorbox}
        \vspace{\baselineskip}
      }

    \par
    \ResumeLineNumbers
  }

\def\@title{}

\hook_gput_code:nnn { begindocument/end } { homework }
  {
    \tl_if_empty:NF \@title
      {
        \maketitle
      }
  }

%%================================
%%  Page # of ##
%%================================

\projlib_langauge_define_multilingual_text:Nn \l__homework_page_of_total_tl
  {
    , EN = { Page \nobreakspace \,\thepage\, \nobreakspace of \nobreakspace \,\pageref*{LastPage} }
    , FR = { Page \nobreakspace \,\thepage\, \nobreakspace sur \nobreakspace \,\pageref*{LastPage} }
    , DE = { Seite \nobreakspace \,\thepage\, \nobreakspace von \nobreakspace \,\pageref*{LastPage} }
    , IT = { Pagina \nobreakspace \,\thepage\, \nobreakspace di \nobreakspace \,\pageref*{LastPage} }
    , PT = { Página \nobreakspace \,\thepage\, \nobreakspace de \nobreakspace \,\pageref*{LastPage} }
    , BR = { Página \nobreakspace \,\thepage\, \nobreakspace de \nobreakspace \,\pageref*{LastPage} }
    , ES = { Página \nobreakspace \,\thepage\, \nobreakspace de \nobreakspace \,\pageref*{LastPage} }
    , CN = { 第 \,\thepage\, 页，共 \,\pageref*{LastPage}\, 页 }
    , TC = { 第 \,\thepage\, 頁，共 \,\pageref*{LastPage}\, 頁 }
    , JP = { ページ \nobreakspace \,\thepage\, / \,\pageref*{LastPage} }
    , RU = { Страница \nobreakspace \,\thepage\, \nobreakspace из \nobreakspace \,\pageref*{LastPage} }
  }

\RequirePackage { lastpage }
\fancypagestyle { fancy }
  {
    \if@twoside
      \fancyfoot[RO,LE]{\small\color{main-text!27!paper} \l__homework_page_of_total_tl }
    \else
      \fancyfoot[R]{\small\color{main-text!27!paper} \l__homework_page_of_total_tl }
    \fi
  }
\pagestyle { fancy }

%%================================
%%  Colored solution environment
%%================================

\projlib_langauge_define_multilingual_text:Nn \l__homework_solution_tl
  {
    , EN = { Solution }
    , FR = { Solution }
    , DE = { Lösung }
    , IT = { Soluzione }
    , PT = { Solução }
    , BR = { Solução }
    , ES = { Solución }
    , CN = { 解 }
    , TC = { 解 }
    , JP = { 解答 }
    , RU = { Решение }
  }

\projlib_langauge_define_multilingual_text:Nn \l__homework_answer_tl
  {
    , EN = { Answer }
    , FR = { Réponse }
    , DE = { Antwort }
    , IT = { Risposta }
    , PT = { Resposta }
    , BR = { Resposta }
    , ES = { Respuesta }
    , CN = { 答 }
    , TC = { 答 }
    , JP = { 解答 }
    , RU = { Ответ }
  }

\newlist{soluenumerate}{enumerate}{3}
\setlist[soluenumerate]{labelsep=*, leftmargin=*}
\setlist[soluenumerate,1]{label = \normalfont$\big(\mskip-.5mu$\arabic*$\mskip-.5mu\big)$,
    ref = \normalfont\color{.!45!paper}$\big(\mskip-.5mu$\arabic*$\mskip-.5mu\big)$,
    leftmargin= \l__minimalist_item_indentation_dim + 2em }
\setlist[soluenumerate,2]{label = \normalfont$\big(\mskip-.5mu$\roman*$\mskip-.5mu\big)$,
    ref = \normalfont\color{.!45!paper}$\big(\mskip-.5mu$\arabic{soluenumeratei}.\roman*$\mskip-.5mu\big)$}
\setlist[soluenumerate,3]{label = \normalfont$\big(\mskip-.5mu$\emph{\alph*}$\mskip-.5mu\big)$,
    ref = \normalfont\color{.!45!paper}$\big(\mskip-.5mu$\arabic{soluenumeratei}.\roman{soluenumerateii}.\emph{\alph*}$\mskip-.5mu\big)$}

\newcommand\soluline{\bgroup\markoverwith{\rule[-.45ex]{1pt}{.75pt}}\ULon}
\NewDocumentEnvironment { solution } { O{ \l__homework_solution_tl } }
  {
    \par
    \topsep0\p@\relax
    \let\enumerate\soluenumerate
    \let\endenumerate\endsoluenumerate
    \setlist*[1]{itemsep=0\baselineskip, parsep=.5\parskip}
    \setlist*[2]{itemsep=0\baselineskip, parsep=.5\parskip}
    \trivlist
    \color{\l__homework_solution_color_tl}
    \item[\hskip\labelsep\soluline{#1}\nobreakspace\nobreakspace]
    \let\qedsymbol\customqedsymbol
    \ignorespaces
  }
  {
    \pushQED{\qed}
    \popQED\endtrivlist\@endpefalse
  }

\NewDocumentEnvironment { answer } { O{ \l__homework_answer_tl } }
  {
    \begin{solution}[#1]
  }
  {
    \end{solution}
  }

%%================================
%%  Configuration of the theorems
%%================================

\newcounter { homework }
\SetTheorem { problem, question, exercise } { shared counter = homework }
\SetTheorem { definition, lemma, theorem, proposition, corollary, example, fact, remark, assertion, assumption, claim, commentary, conclusion, conjecture, construction, convention, hypothesis, motivation, notation, observation, postulate, property, recall } { number within = homework }
\SetTheorem { definitions, lemmas, theorems, propositions, corollaries, examples, facts, remarks, assertions, assumptions, claims, commentaries, conclusions, conjectures, constructions, conventions, hypotheses, motivations, notations, observations, postulates, properties, recalls } { number within = homework }

%%================================
%%  Custom numbering
%%================================

\tl_new:N \l__homework_counter_backup_tl
\NewDocumentCommand \ManualNumbering { m m }
  {
    \addtocounter { #1 } { -1 }
    \tl_set_eq:Nc \l__homework_counter_backup_tl { the #1 }
    \tl_set:cn { the #1 } { #2 }
    \hook_gput_next_code:nn { env/#1/after }
      {
        \tl_set_eq:cN { the #1 } \l__homework_counter_backup_tl
      }
  }

%%================================
%%  Hide solution
%%================================

\RequirePackage { verbatim }

\bool_if:NT \l__homework_hide_solution_bool
  {
    \let\solution=\comment
    \let\endsolution=\endcomment
    \let\answer=\comment
    \let\endanswer=\endcomment
  }

\prg_new_conditional:Nnn \homework_if_solution_shown: { T, F, TF }
  {
    \bool_if:NTF \l__homework_hide_solution_bool
      { \prg_return_false: }
      { \prg_return_true: }
  }
\NewCommandCopy \IfSolutionT  \homework_if_solution_shown:T
\NewCommandCopy \IfSolutionF  \homework_if_solution_shown:F
\NewCommandCopy \IfSolutionTF \homework_if_solution_shown:TF
\NewCommandCopy \IfAnswerT    \homework_if_solution_shown:T
\NewCommandCopy \IfAnswerF    \homework_if_solution_shown:F
\NewCommandCopy \IfAnswerTF   \homework_if_solution_shown:TF

\bool_if:NTF \l__homework_hide_solution_bool
  {
    \setlist*[1]{itemsep=0\baselineskip, parsep=\parskip}
    \setlist*[2]{itemsep=0\baselineskip, parsep=\parskip}
  }
  {
    \setlist*[1]{itemsep=.5\baselineskip, parsep=\parskip, after*=\medskip}
    \setlist*[2]{itemsep=.3\baselineskip, parsep=\parskip}
  }

\endinput
%%
%% End of file `homework.cls'.
