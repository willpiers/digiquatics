class SlideInspection < ActiveRecord::Base
  belongs_to :user
  belongs_to :slide
  has_many :slide_inspection_tasks

  accepts_nested_attributes_for :slide_inspection_tasks

  TASKS = [
    'Dry Slide Inspection (obstructions, cracks, chips, bubbles, fiberglass.)',
    'Tower and Support Foundations (cracks, missing concrete.)',
    'Base Plates and Fasteners (missing/loose bolts/fasteners, excessive rusting.)',
    'Supports, Upright and Columns (damaged/missing components, signs of deterioration.)',
    'Stairs and Landing (sharp/broken sections of concrete)',
    'Handrails (missing/loose fasteners, stability, secure.)',
    'Non-Skid Stairs and Landing Surface',
    'Side Protections, Guardrails (missing/loose fasteners, stability, secure,no gaps in side protection.)',
    'Landing Start Pool (secure to landing, missing/loose fasteners, rusting, deterioration.)',
    'Splash Down Water level in operating range',
    'Condition of Section Connectors/Joints (alignment, damage.)',
    'Visual Check of Innertubes (WH Only) (scrapes, punctures.)',
    'Condition of Piping, Joints (leaking, excessive rust, missing/loose bolts/fasteners.)',
    'Piping Supports/Hangers (secure, missing/loose bolts/fasteners, excessive rusting.)',
    'Excessive movement of flume',
    'Slide End Section Secure to Pool (signs of deterioration/damage to concrete, loose/missing bolts/fasteners)',
    'Pool Handrails and Exit Steps (secure, loose/missing bolts/fasteners)',
    'Area Lighting',
    'Warning Signage (legible, properly mounted.)',
    'Rules/Height Requirement Signage (legible, properly mounted.)',
    'Emergency Stop Button (working order, protected)',
    'Pool Grate and Drain Covers (secure, broken.)',
    'Pool Depth Markers (Legible)',
    'Ride through one complete cycle'
  ]
end
