package coc.view {
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.display.DisplayObject;

    import flash.text.TextField;

    import coc.model.GameModel;

    // Remove dynamic once you've added all the DOs as instance properties.
    public dynamic class StatsView extends Sprite {
        // add things from main view here?
        // yes because we'll need to update all the TFs and progress bars.
        public var upDownsContainer :Sprite;

        protected var model :GameModel;

        public function StatsView( mainView :MovieClip, model :* ) {
            super();

            if( ! mainView ) {
                return;
            }

            this.model = model;

            var statsThingsNames :Array = [
                    "strBar",     "strText",     "strNum",      // "strUp",      "strDown",
                    "touBar",     "touText",     "touNum",      // "touUp",      "touDown",
                    "speBar",     "speText",     "speNum",      // "speUp",      "speDown",
                    "inteBar",    "inteText",    "inteNum",     // "inteUp",     "inteDown",
                    "libBar",     "libText",     "libNum",      // "libUp",      "libDown",
                    "sensBar",    "senText",     "senNum",      // "sensUp",     "sensDown",
                    "corBar",     "corText",     "corNum",      // "corUp",      "corDown",
                    "fatigueBar", "fatigueText", "fatigueNum",  // "fatigueUp",  "fatigueDown",
                    "HPBar",      "HPText",      "HPNum",       // "hpUp",       "hpDown",
                    "lustBar",    "lustText",    "lustNum",     // "lustUp",     "lustDown",
                                  "levelText",   "levelNum",    // "levelUp",
                                   "xpText",     "xpNum",       // "xpUp",       "xpDown",
                    "coreStatsText",
                    "advancementText",
                    "combatStatsText",
                    "gemsText",   "gemsNum",
                    "timeText",
                    "timeBG",
                    "sideBarBG"
                ];

            var statsUpDownsNames :Array = [
                    "strUp",      "strDown",
                    "touUp",      "touDown",
                    "speUp",      "speDown",
                    "inteUp",     "inteDown",
                    "libUp",      "libDown",
                    "sensUp",     "sensDown",
                    "corUp",      "corDown",
                    "fatigueUp",  "fatigueDown",
                    "hpUp",       "hpDown",
                    "lustUp",     "lustDown",
                    "levelUp",
                    "xpUp",       "xpDown"
                ];

            for each( var statsDOName :* in statsThingsNames ) {
                // adding at 0 because BG is at the end.
                this.addChildAt( mainView.getChildByName( statsDOName ), 0 );
            }

            this.upDownsContainer = new Sprite();
            this.addChild( this.upDownsContainer );

            for each( var statsUpDownDOName :* in statsUpDownsNames ) {
                this.upDownsContainer.addChild( mainView.getChildByName( statsUpDownDOName ) );
            }
        };

        protected function setStatText( name :String, value :* ) {
            (this.getChildByName( name ) as TextField).htmlText = String( Math.floor( value ) );
        };

        protected function setStatBar( name :String, progress :Number ) {
            this.getChildByName( name ).width = Math.round( progress * 115 );
        };

        // <- statsScreenRefresh
        public function refresh() :void {
            this.show();

            //Make sure it's all visible

            setStatText( "coreStatsText",
                "<b><u>Name : {NAME}</u>\nCore Stats</b>"
                    .replace( "{NAME}", model.player.short ) );

            setStatText( "strNum", model.player.str );
            setStatText( "touNum", model.player.tou );
            setStatText( "speNum", model.player.spe );
            setStatText( "inteNum", model.player.inte );
            setStatText( "libNum", model.player.lib );
            setStatText( "senNum", model.player.sens );
            setStatText( "corNum", model.player.cor );
            setStatText( "fatigueNum", model.player.fatigue );
            setStatText( "HPNum", model.player.HP );
            setStatText( "lustNum", model.player.lust );
            setStatText( "levelNum", model.player.level );

            if( model.player.XP > 9999 )
                setStatText( "xpNum", "++++" );
            else
                setStatText( "xpNum", model.player.XP );

            setStatText( "timeText",
                "<b><u>Day #: {DAYS}</u></b>\n<b>Time : {HOURS}:00</b>"
                    .replace( "{DAYS}", model.time.days )
                    .replace( "{HOURS}", model.time.hours ) );

            setStatBar( "strBar", model.player.str/100 );
            setStatBar( "touBar", model.player.tou/100 );
            setStatBar( "speBar", model.player.spe/100 );
            setStatBar( "inteBar", model.player.inte/100 );
            setStatBar( "libBar", model.player.lib/100 );
            setStatBar( "sensBar", model.player.sens/100 );
            setStatBar( "corBar", model.player.cor/100 );
            setStatBar( "fatigueBar", model.player.fatigue/100 );
            setStatBar( "HPBar", model.player.HP/model.maxHP() );
            setStatBar( "lustBar", model.player.lust/100 );

            if( model.player.gems > 9999 )
                setStatText( "gemsNum", "++++" );
            else
                setStatText( "gemsNum", model.player.gems );
        };

        // <- showStats
        public function show() {
            // make all the stats DOs visible.
            this.refresh();
            this.visible = true;
        };

        // <- hideStats
        public function hide() {
            // body...
            this.visible = false;
        };

        // <- hideUpDown
        public function hideUpDown() {
            var ci,
                cc = this.upDownsContainer.numChildren;

            this.upDownsContainer.visible = false;

            // children also need to be hidden because they're selectively shown on change.
            for( ci = 0; ci < cc; ++ci ) {
                this.upDownsContainer.getChildAt( ci ).visible = false;
            }
        };
    }
}