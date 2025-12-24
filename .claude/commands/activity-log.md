# Activity Log - Track All Physical Activities

Track running, padel, and other cardio activities.

## Usage
```
/activity-log [activity] [details...]
```

## Examples
- `/activity-log run 5km 5:30/km 27:30`
- `/activity-log padel 90min competitive`
- `/activity-log walk 3km casual 45min`
- `/activity-log interval 30min treadmill`

## Function
1. Find or create today's daily report
2. Add to Cardio/Activity section
3. Format appropriately based on activity type
4. For running: compare to target pace (5:30/km)
5. For padel: note intensity and duration

## Activity Types
- **run** - Distance, pace, duration
- **padel** - Duration, intensity level
- **walk** - Distance, intensity, duration  
- **interval** - Duration, type, intensity
- **other** - Custom activity description

## Requirements
- Flexible format based on activity type
- Automatically note performance vs targets for running
- Track all cardio for weekly analysis
- Include intensity/competition level for sports