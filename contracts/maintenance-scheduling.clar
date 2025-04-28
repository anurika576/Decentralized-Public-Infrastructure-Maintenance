;; Maintenance Request Contract
;; Tracks identified repair needs

(define-data-var next-request-id uint u1)

(define-map maintenance-requests
  { request-id: uint }
  {
    asset-id: uint,
    description: (string-utf8 500),
    priority: uint,  ;; 1=Low, 2=Medium, 3=High, 4=Emergency
    status: uint,    ;; 1=Open, 2=Assigned, 3=In Progress, 4=Completed, 5=Cancelled
    requester: principal,
    created-at: uint,
    assigned-to: (optional principal),
    estimated-cost: uint
  }
)

(define-public (create-request (asset-id uint) (description (string-utf8 500)) (priority uint))
  (let (
    (request-id (var-get next-request-id))
    (current-time (unwrap-panic (get-block-info? time u0)))
  )
    (begin
      (map-set maintenance-requests
        { request-id: request-id }
        {
          asset-id: asset-id,
          description: description,
          priority: priority,
          status: u1,
          requester: tx-sender,
          created-at: current-time,
          assigned-to: none,
          estimated-cost: u0
        }
      )
      (var-set next-request-id (+ request-id u1))
      (ok request-id)
    )
  )
)

(define-public (assign-request (request-id uint) (contractor principal) (estimated-cost uint))
  (let ((request (map-get? maintenance-requests { request-id: request-id })))
    (if (is-some request)
      (begin
        (map-set maintenance-requests
          { request-id: request-id }
          (merge (unwrap-panic request) {
            status: u2,
            assigned-to: (some contractor),
            estimated-cost: estimated-cost
          })
        )
        (ok true)
      )
      (err u1)
    )
  )
)

(define-public (update-request-status (request-id uint) (new-status uint))
  (let ((request (map-get? maintenance-requests { request-id: request-id })))
    (if (is-some request)
      (begin
        (map-set maintenance-requests
          { request-id: request-id }
          (merge (unwrap-panic request) { status: new-status })
        )
        (ok true)
      )
      (err u1)
    )
  )
)

(define-read-only (get-request (request-id uint))
  (ok (map-get? maintenance-requests { request-id: request-id }))
)
