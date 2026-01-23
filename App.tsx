import React from 'react';
import { Calculator } from './components/Calculator';

const App: React.FC = () => {
  return (
    <div className="min-h-screen w-full bg-[#050505] flex flex-col items-center justify-center relative overflow-x-hidden overflow-y-auto py-10 px-4">
      
      {/* Background Ambient Effects (Fixed Position) */}
      <div className="fixed top-0 left-0 w-full h-full overflow-hidden pointer-events-none z-0">
        <div className="absolute top-[-10%] left-[20%] w-[500px] h-[500px] bg-purple-600/20 rounded-full blur-[128px] opacity-50"></div>
        <div className="absolute bottom-[-10%] right-[20%] w-[500px] h-[500px] bg-blue-600/20 rounded-full blur-[128px] opacity-50"></div>
        <div className="absolute inset-0 bg-[url('https://grainy-gradients.vercel.app/noise.svg')] opacity-20 brightness-100 contrast-150"></div>
      </div>

      {/* Main Container - Centered */}
      <main className="z-10 relative flex flex-col items-center justify-center w-full max-w-7xl mx-auto">
        <Calculator />
        
        <footer className="mt-12 text-center opacity-40 hover:opacity-100 transition-opacity duration-300">
          <p className="text-[10px] font-brand tracking-[0.4em] text-white uppercase">
            ZetFour Technologies
          </p>
          <div className="w-12 h-[1px] bg-gradient-to-r from-transparent via-white/50 to-transparent mx-auto mt-2"></div>
        </footer>
      </main>
    </div>
  );
};

export default App;