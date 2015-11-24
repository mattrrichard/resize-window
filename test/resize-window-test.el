;;; Test for `resize-window'

;;; Commentary:
;; These are the tests for `resize-window'

;;; Code:

(defvar choice-no-capital '(?n 'function "documentation" nil))
(defvar choice-capital '(?n 'function "documentation" t))

(ert-deftest should-match-aliases ()
  (should (equal ?f
                 (rw-match-alias 'right)))
  (should (equal ?b
                 (rw-match-alias 'left)))
  (should (equal ?n
                 (rw-match-alias 'up)))
  (should (equal ?p
                 (rw-match-alias 'down))))

(ert-deftest should-create-documentation-from-alist ()
  (should (equal "n: documentation "
                 (rw-display-choice choice-no-capital)))
  (should (equal "n|N: documentation "
                 (rw-display-choice choice-capital))))

(ert-deftest should-execute-and-display-message ()
  (let ((choice '(?n (lambda () (setq executed t)) "doc" nil))
        (executed)
        (message-received ""))
    (rw-execute-action choice)
    (should (equal executed t))))

(ert-deftest should-identify-which-allow-capital-matching ()
  (should (rw-allows-capitals choice-capital))
  (should-not (rw-allows-capitals choice-no-capital)))
