; 2. 给出3种不同表示(a b c)的cons表达式
(cons 'a '(b c))
(cons 'a (cons 'b '(c)))
(cons 'a (cons 'b (cons 'c '())))

; 3. Use 'car' and 'cdr' to define a function
;    which return the fourth element of a list.
(defun *fourth* (lst)
  (car (cdr (cdr (cdr lst)))))

; 4. define a function which accept two parameters
; and return the bigger one.
(defun *bigger* (x y)
  (if (> x y)
	x
	y))

; 5. what are these functions do?
; 5.1 if exists 'nil' in x, enigma return true, else return false.
(defun enigma (x)
  (and (not (null x))
	   (or (null (car x))
		   (enigma (cdr x)))))
; 5.2 find the position of x in list y.
(defun mystery (x y)
  (if (null y)
	nil
	(if (eql x (car y))
	  0
	  (let ((z (mystery x (cdr y))))
		(and z (+ z 1))))))

; 6. 下列表达式，x该是什么，才会得到相同的结果
; 6.1 x is car
(car (car (cdr '(a (b c) d))))
; 6.2 x is or
(or 13 (/ 1 0))
; 6.3 x is apply
(apply #'list 1 nil)

; 7. 用本章中的操作符，定义一个函数，它接受一个列表做参数，
; 如果有一个元素为列表就返回真
(defun is-any-list (lst)
  (if (null lst)
	nil
	(if (listp (car lst))
	  t
	  (is-any-list (cdr lst)))))
(print (is-any-list '(a (b c) d)))
(defun is-any-list_iteration_version (lst)
  (let ((ret nil))
	(dolist (elem lst)
	  (if (listp elem)
		(setf ret t)))))
(is-any-list_iteration_version '(a (b c) d))

; 8. 给出函数的递归与迭代版本
; 8.1 接受一个正整数，并打印那么多数目的点
; 8.1-itoration version
(format t "~%")

(defun print-dots-itoration (amount)
  (do ((i 1 (+ i 1))) ((> i amount) 'done)
	(format t ".")))
(print-dots-itoration 50)

; 8.1-recursive version
(format t "~%")

(defun print-dots-recursive (amount)
  (if (eql amount 1)
	(or (format t ".") t)
	(or (format t ".") (print-dots-recursive (- amount 1)))))
(print-dots-recursive 5)

; 8.2 接受一个列表，并返回a在列表中出现的次数
; 8.2-iteration version
(format t "~%")
(defun how-many-a (lst)
  (let ((x 0))
	(dolist (elem lst)
	  (if (eql elem 'a)
		(setf x (+ x 1))))
	x))
(format t "~A~%" (how-many-a '(a b a b a b c)))

; 8.2-recursive version
(defun how-many-a_recursive (lst)
  (if (null lst)
	0
	(if (eql 'a (car lst))
	  (+ 1 (how-many-a_recursive (cdr lst)))
	  (how-many-a_recursive (cdr lst)))))
(format t "~A~%" (how-many-a_recursive '(a b a b a b c)))

; 9. 下面函数返回列表中所有非nil元素的和，但是两个版本都有错误，请修正。
; 9.1
;(defun summit-1 (lst)
;  (remove nil lst)
;  (apply #'+ lst))
(defun summit-1 (lst)
  (setf lst (remove nil lst))
  (apply #'+ lst))
(format t "~A~%" (summit-1 '(1 nil 2 3 nil 4)))

; 9.2
;(defun summit-2 (lst)
;  (let ((x (car lst)))
;	(if (null x)
;	  (summit-2 (cdr lst))
;	  (+ x (summit-2 (cdr lst)))))
(defun summit-2 (lst)
  (if (null lst)
	0
	(let ((x (car lst)))
		  (if (null x)
			(summit-2 (cdr lst))
			(+ x (summit-2 (cdr lst)))))))
(format t "~A~%" (summit-2 '(1 nil 2 3 nil 4)))
