import { 
  FaStar, FaReact, FaDatabase, FaLayerGroup, FaJs, FaCode
} from 'react-icons/fa';
import { 
  SiMongodb, SiDotnet, SiTypescript, SiJavascript, SiTailwindcss, SiGithub 
} from 'react-icons/si';
import { 
  HiOutlineExternalLink, HiOutlineGlobe, HiOutlineTerminal, 
  HiOutlineDeviceTablet, HiOutlineBookOpen, HiOutlinePuzzle, 
  HiOutlineDuplicate, HiOutlineServer, HiOutlinePencil, 
  HiOutlineSun, HiOutlineClipboardList, HiOutlineCurrencyDollar,
  HiOutlineUserGroup, HiOutlineViewGrid, HiOutlineArrowCircleUp,
  HiOutlineHand, HiOutlineX
} from 'react-icons/hi';
import { IoGameControllerOutline } from 'react-icons/io5';
import { useState } from 'react';
import { motion, AnimatePresence } from 'framer-motion';

const PROJECTS = [
  { 
    title: 'Gadd Kaam — SkillSwap Pakistan -MERN Stack', 
    icon: <HiOutlineUserGroup />, 
    desc: 'A secure, MERN-stack platform for cashless skill exchanging featuring CNIC verification and real-time trading.', 
    tech: ['MongoDB', 'Express.js', 'React.js', 'Node.js'], 
    live: 'https://gadd-kaam-skillswap-pakistan.netlify.app/', 
    code: 'https://github.com/farmanullah1/Gadd-Kaam-SkillSwap-Pakistan', 
    featured: true 
  },
  { 
    title: 'Nexa-Habit-Habit-Tracker-App', 
    icon: <HiOutlineSun />, 
    desc: 'Nexa Habit is a modern, high-performance habit tracking web application designed with a Glassmorphism aesthetic (inspired by iOS design language). It features soft gradients, deep blur effects, and smooth animations to provide a calm and focused productivity experience.', 
    tech: ['React.js', 'Framer Motion', 'OpenWeatherMap', 'WeatherAPI'], 
    live: 'https://farmanullah1.github.io/Nexa-Habit-Habit-Tracker-App/', 
    code: 'https://github.com/farmanullah1/Nexa-Habit-Habit-Tracker-App'
  },
  { 
    title: 'SkyCast - Weather Dashboard - React.js', 
    icon: <HiOutlineSun />, 
    desc: 'A fully functional, modern, and animated Weather Dashboard built with React, Vite, Framer Motion, OpenWeatherMap, and WeatherAPI. Features include real-time weather data, a 5-day forecast, hourly forecast, stunning dynamic backgrounds, temperature unit toggling, and geolocation support.', 
    tech: ['React.js', 'Framer Motion', 'Tailwind CSS'],  
    live: 'https://farmanullah1.github.io/SkyCast--Weather-Dashboard/', 
    code: 'https://github.com/farmanullah1/SkyCast--Weather-Dashboard'
  },
  { 
    title: 'Taskly - Modern Todo Task Manager App - React.js', 
    icon: <HiOutlineClipboardList />, 
    desc: 'A sleek and efficient task management application with a beautiful glassmorphism UI, task persistence, and smooth Framer Motion animations.', 
    tech: ['React.js', 'Framer Motion', 'Tailwind CSS'], 
    live: 'https://farmanullah1.github.io/Taskly---Modern-Todo-Task-Manager-App/', 
    code: 'https://github.com/farmanullah1/Taskly---Modern-Todo-Task-Manager-App'
  },
  { 
    title: 'BalanceByte - ASP.NET Core', 
    icon: <HiOutlineCurrencyDollar />, 
    desc: 'Simple mobile balance checker with smooth UI transitions that tells you how much total balance you will get if you load a specific amount (e.g., load 100)', 
    tech: ['C#', 'ASP.NET Core', 'MVC', 'SQL Server'], 
    live: '', 
    code: 'https://github.com/farmanullah1/BalanceByte-ASP.NET-Core-MVC-App'
  },
  { 
    title: 'iNotebook - Cloud Notes', 
    icon: <HiOutlineBookOpen />, 
    desc: 'Secure MERN stack application for managing notes on the cloud, featuring JWT authentication and persistent storage.', 
    tech: ['Node.js', 'React.js', 'MongoDB', 'Express'], 
    live: 'https://farmanullah1.github.io/iNotebook/', 
    code: 'https://github.com/farmanullah1/iNotebook' 
  },
  { 
    title: 'Kurrent News', 
    icon: <HiOutlineGlobe />, 
    desc: 'A global news SPA featuring a Triple-API fallback architecture, infinite scrolling, and dark mode.', 
    tech: ['React.js', 'NewsAPI', 'Bootstrap'], 
    live: 'https://farmanullah1.github.io/Kurrent-News-Top-Headlines-Tech-Politics-Sports/', 
    code: 'https://github.com/farmanullah1/Kurrent-News-Top-Headlines-Tech-Politics-Sports' 
  },
  { 
    title: 'Memory Card Matching Game', 
    icon: <HiOutlinePuzzle />, 
    desc: 'A beautiful, fully responsive memory card matching game built with React, TypeScript, and Vite. This game features smooth animations, multiple themes, sound effects, and high score tracking.', 
    tech: ['React.js', 'TypeScript', 'Vite'], 
    live: 'https://farmanullah1.github.io/Memory-Card-Matching-Game/', 
    code: 'https://github.com/farmanullah1/Memory-Card-Matching-Game' 
  },
  { 
    title: 'TextRepeat Studio', 
    icon: <HiOutlineDuplicate />, 
    desc: 'Highly efficient text manipulation and repetition tool built with React for rapid content generation and formatting.', 
    tech: ['React.js', 'JavaScript'], 
    live: 'https://farmanullah1.github.io/TextRepeat---React/', 
    code: 'https://github.com/farmanullah1/TextRepeat---React' 
  },
  { 
    title: 'ASP.NET Core CRUD API', 
    icon: <HiOutlineServer />, 
    desc: 'Robust REST API demonstrating repository patterns, efficient CRUD operations, and modern .NET backend practices.', 
    tech: ['C#', 'ASP.NET Core', 'Web API'], 
    live: '', 
    code: 'https://github.com/farmanullah1/CRUD-App-Using-ASP-Core-Web-API' 
  },
  { 
    title: 'BalanceWave - React', 
    icon: <HiOutlineDeviceTablet />, 
    desc: 'Create a mobile balance checker that lets a user enter an amount they want to load (for example, 100), and then shows how much total balance they will get after loading that amount. The interface should be simple, modern, and mobile‑friendly, with smooth transitions.', 
    tech: ['React.js', 'Framer Motion', 'Tailwind CSS'], 
    live: 'https://farmanullah1.github.io/BalanceWave-React/', 
    code: 'https://github.com/farmanullah1/BalanceWave-React' 
  },
  { 
    title: 'Stone, Paper, Scissors', 
    icon: <HiOutlineHand />, 
    desc: 'Interactive browser game featuring dynamic UI updates and classic game logic.', 
    tech: ['HTML', 'CSS', 'JavaScript'], 
    live: 'https://farmanullah1.github.io/Stone-Paper-Scissors-Game-HTML-CSS-JS/', 
    code: 'https://github.com/farmanullah1/Stone-Paper-Scissors-Game-HTML-CSS-JS' 
  },
  { 
    title: 'TextUtils Studio', 
    icon: <HiOutlinePencil />, 
    desc: 'Premium browser-based text manipulation toolkit with a "Deep Cyber Glass" UI offering 100+ formatting, extraction, and cryptography tools.', 
    tech: ['React.js','Bootstrap'], 
    live: 'https://farmanullah1.github.io/TextUtils-React.js/', 
    code: 'https://github.com/farmanullah1/TextUtils-React.js' 
  },
  {
    title: "❌⭕ Tic-Tac-Toe",
    icon: <HiOutlineX />,
    desc: "A classic Tic-Tac-Toe web game featuring responsive design and state management for turn-based gameplay.",
    tech: ["HTML", "CSS", "JavaScript"],
    live: "https://farmanullah1.github.io/Tic-Tac-Toe-HTML-CSS-JS/",
    code: "https://github.com/farmanullah1/Tic-Tac-Toe-HTML-CSS-JS"
  },
  { 
    title: 'Modern Tetris', 
    icon: <HiOutlineViewGrid />, 
    desc: 'A sleek, TypeScript-powered rendition of the classic arcade game featuring fluid animations, score tracking, and progressive difficulty.', 
    tech: ['TypeScript', 'HTML5 Canvas', 'CSS3'], 
    live: 'https://farmanullah1.github.io/Modern-Tetris/', 
    code: 'https://github.com/farmanullah1/Modern-Tetris' 
  },
  { 
    title: 'Classic Snake Game', 
    icon: <HiOutlineArrowCircleUp />, 
    desc: 'A high-performance Snake game built with TypeScript, emphasizing clean code architecture and responsive controls.', 
    tech: ['TypeScript', 'CSS', 'JavaScript'], 
    live: 'https://farmanullah1.github.io/Snake-Game/', 
    code: 'https://github.com/farmanullah1/Snake-Game' 
  },
  { 
    title: 'Old Portfolio - (2024)', 
    icon: <HiOutlineTerminal />, 
    desc: 'My 2024 Portfolio Website built with HTML,CSS and JavaScript, emphasizing clean code architecture and responsive controls.', 
    tech: ['HTML', 'CSS', 'JavaScript','Web Basics'], 
    live: 'https://farmanullah1.github.io/Portfolio-2024/', 
    code: 'https://github.com/farmanullah1/Portfolio-2024' 
  },
  { 
    title: 'Portfolio - HTML CSS JS (2025)', 
    icon: <HiOutlineTerminal />, 
    desc: 'My Old portfolio website made with HTML, CSS and JavaScript.', 
    tech: ['HTML', 'CSS', 'JavaScript','GSAP'], 
    live: 'https://farmanullah1.github.io/Portfolio-HTML-CSS-JS/', 
    code: 'https://github.com/farmanullah1/Portfolio-HTML-CSS-JS' 
  },
  { 
    title: 'MyPortfolio - (Latest - 2026)', 
    icon: <FaCode />, 
    desc: 'My Portfolio Website built with React.js, emphasizing clean code architecture and responsive controls.', 
    tech: ['React.js', 'CSS', 'JavaScript','GSAP'], 
    live:  'https://farmanullah1.github.io/My-Portfolio/', 
    code: 'https://github.com/farmanullah1/My-Portfolio' 
  },
];
const FILTERS = [
  { name: 'All', icon: <FaLayerGroup /> },
  { name: 'Featured', icon: <FaStar /> },
  { name: 'MERN', icon: <SiMongodb /> },
  { name: 'Full Stack', icon: <FaDatabase /> },
  { name: 'React.js', icon: <FaReact /> },
  { name: '.NET', icon: <SiDotnet /> },
  { name: 'TypeScript', icon: <SiTypescript /> },
  { name: 'JavaScript', icon: <SiJavascript /> },
  { name: 'Games', icon: <IoGameControllerOutline /> },
  { name: 'Tailwind CSS', icon: <SiTailwindcss /> },
  { name: 'Vanilla JS', icon: <FaJs /> },
];

const match = (p, f) => {
  const tech = p.tech.map(t => t.toLowerCase());
  const title = p.title.toLowerCase();
  
  if (f === 'All') return true;
  if (f === 'Featured') return p.featured;
  if (f === 'MERN') return tech.includes('mongodb');
  if (f === 'Full Stack') return tech.includes('mongodb') || tech.includes('sql server') || tech.includes('node.js') || tech.includes('express');
  if (f === 'React.js') return tech.includes('react.js') || tech.includes('react');
  if (f === '.NET') return tech.includes('c#') || tech.includes('asp.net core') || tech.includes('web api');
  if (f === 'TypeScript') return tech.includes('typescript');
  if (f === 'JavaScript') return tech.includes('javascript');
  if (f === 'Games') {
    const keywords = ['game', 'tetris', 'tic-tac-toe', 'scissors', 'matching', 'snake'];
    return keywords.some(kw => title.includes(kw));
  }
  if (f === 'Tailwind CSS') return tech.includes('tailwind css') || tech.includes('tailwind');
  if (f === 'Vanilla JS') return (tech.includes('javascript') || tech.includes('js')) && !tech.includes('react.js') && !tech.includes('react') && !tech.includes('typescript');
  
  return p.tech.includes(f);
};

const Projects = () => {
  const [filter, setFilter] = useState('All');
  const [visibleCount, setVisibleCount] = useState(8);
  const filtered = PROJECTS.filter(p => match(p, filter));
  const displayed = filtered.slice(0, visibleCount);
  const hasMore = visibleCount < filtered.length;

  const loadMore = () => {
    setVisibleCount(prev => prev + 8);
  };

  return (
    <section className="projects" id="projects">
      <motion.h2 initial={{ opacity:0, y:-20 }} whileInView={{ opacity:1, y:0 }} viewport={{ once:true }}>
        Featured Projects
      </motion.h2>
      <div className="filter-container">
        {FILTERS.map(f => (
          <motion.button key={f.name} className={`filter-btn${filter===f.name?' active':''}`}
            onClick={() => {
              setFilter(f.name);
              setVisibleCount(8);
            }} whileHover={{ scale:1.06 }} whileTap={{ scale:.94 }}>
            <span className="filter-icon">{f.icon}</span>
            {f.name}
          </motion.button>
        ))}
      </div>
      <motion.div layout className="project-grid">
        <AnimatePresence mode="popLayout">
          {displayed.map(proj => (
            <motion.div
              className={`project-card${proj.featured?' project-card--featured':''}`}
              key={proj.title} layout
              initial={{ opacity:0, scale:.88 }} animate={{ opacity:1, scale:1 }} exit={{ opacity:0, scale:.88 }}
              transition={{ duration:.32 }} whileHover={{ y:-9 }}
            >
              {proj.featured && <div className="project-featured-badge"><FaStar /> Featured</div>}
              <div className="project-icon">{proj.icon}</div>
              <h3>{proj.title}</h3>
              <p>{proj.desc}</p>
              <div className="tech-stack">
                {proj.tech.map((t,i) => (
                  <span key={i}>
                    {t}
                  </span>
                ))}
              </div>
              <div className="project-links">
                {proj.live && <a href={proj.live} target="_blank" rel="noreferrer" className="project-link project-link--live"><HiOutlineExternalLink /> Live Demo</a>}
                {proj.code && <a href={proj.code} target="_blank" rel="noreferrer" className="project-link project-link--code"><SiGithub /> Source Code</a>}
              </div>
            </motion.div>
          ))}
        </AnimatePresence>
      </motion.div>
      {hasMore && (
        <motion.div className="more-button-container" initial={{ opacity:0, y:20 }} whileInView={{ opacity:1, y:0 }} viewport={{ once:false }}>
          <motion.button className="more-button" onClick={loadMore} whileHover={{ scale:1.04 }} whileTap={{ scale:.97 }}>
            More Projects
          </motion.button>
        </motion.div>
      )}
    </section>
  );
};
export default Projects;